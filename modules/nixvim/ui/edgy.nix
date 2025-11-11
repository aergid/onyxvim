{
  lib,
  config,
  ...
}: {
  options = {ui.edgy.enable = lib.mkEnableOption "Enable edgy module";};

  config = lib.mkIf config.ui.edgy.enable {
    plugins.edgy = {
      enable = true;
    };
  };
}
