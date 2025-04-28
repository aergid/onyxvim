{
  lib,
  config,
  ...
}: {
  options = {
    languages.markview.enable = lib.mkEnableOption "Enable markview";
  };

  config = lib.mkIf config.languages.markview.enable {
    plugins.markview = {
      enable = true;
      settings = {
        preview = {
          buf_ignore = [];
          hybrid_modes = [
            "i"
            "r"
          ];
          modes = [
            "n"
            "x"
          ];
        };
      };
    };
  };
}
