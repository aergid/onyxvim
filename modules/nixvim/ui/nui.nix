{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    ui.nui.enable = lib.mkEnableOption "Enable nui module";
  };
  config = lib.mkIf config.ui.nui.enable {
    extraPlugins = with pkgs.vimPlugins; [ nui-nvim ];
  };
}
