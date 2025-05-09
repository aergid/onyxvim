{ lib
, pkgs
, inputs
, ...
}:
let
  raw-modules = lib.snowfall.fs.get-nix-files-recursive (
    lib.snowfall.fs.get-file "/modules/nixvim"
  );

  wrapped-modules = builtins.map
    (
      raw-module:
      args@{ ... }:
      let
        module = import raw-module;
        result =
          if builtins.isFunction module then
            module
              (
                args
                // {
                  # NOTE: nixvim doesn't allow for these to be customized so we must work around the
                  # module system here...
                  inherit lib pkgs;
                }
              )
          else
            module;
      in
      result // { _file = raw-module; }
    )
    raw-modules;

  raw-neovim = pkgs.nixvim.makeNixvimWithModule {
    inherit pkgs;

    module = {
      imports = wrapped-modules;

      config = lib.mkMerge [
        {
          _module.args = {
            lib = lib.mkForce lib;
            pkgs = lib.mkForce pkgs;
          };
        }
      ];
    };
  };

  neovim = raw-neovim.overrideAttrs (attrs: {
    meta = attrs.meta // {
      # NOTE: The default platforms specified aren't actually all
      # supported by nixvim. Instead, only support the ones that can build with
      # the module system.
      platforms = builtins.attrNames inputs.nixvim.legacyPackages;
    };
  });
in
neovim
