{ lib, config, ... }:
{
  options = {
    ui.web-devicons.enable = lib.mkEnableOption "Enable web-devicons module";
  };
  config = lib.mkIf config.ui.web-devicons.enable {
    plugins.web-devicons.enable = true;
  };
}
