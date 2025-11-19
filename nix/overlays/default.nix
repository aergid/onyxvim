# Example overlay:
/*
importName: inputs: let
  overlay = self: super: { 
    ${importName} = SOME_DRV;
    # or
    ${importName} = {
      # define your overlay derivations here
    };
  };
in
overlay
*/

inputs: let 
  inherit (inputs.nixCats) utils;
  overlaySet = {
    # kotlin-lsp = import ./kotlin-lsp.nix;
    aider-wrapped = import ./aider-wrapped.nix;
    opencode = import ./opencode.nix;

  };
  extra = [
    (utils.sanitizedPluginOverlay inputs)
    # add any flake overlays here.
    inputs.neorg-overlay.overlays.default
    # inputs.tomlua.overlays.default
    # inputs.neovim-nightly-overlay.overlays.default
    # (utils.fixSystemizedOverlay inputs.windsurf.overlays
    #   (system: inputs.windsurf.overlays.${system}.default)
    # )
  ];
in
builtins.attrValues (builtins.mapAttrs (name: value: (value name inputs)) overlaySet) ++ extra
