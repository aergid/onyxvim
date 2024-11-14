{ lib, config, ... }:
{
  options = {
    ui.web-devicons.enable = lib.mkEnableOption "Enable web-devicons module";
  };
  config = lib.mkIf config.ui.web-devicons.enable {
    plugins.mini.enable = true;
    plugins.mini.modules.icons.enable = true;
    plugins.mini.mockDevIcons = true;
  };
}
