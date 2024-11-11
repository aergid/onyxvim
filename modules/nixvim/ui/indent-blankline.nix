{ lib, config, ... }:
{
  options = {
    ui.indent-blankline.enable = lib.mkEnableOption "Enable indent-blankline module";
  };
  config = lib.mkIf config.ui.indent-blankline.enable {

    plugins = {
      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "│"; # "│" or "▎"
          };
          scope = {
            enabled = true;
            show_start = true;
          };
          exclude = {
            buftypes = [
              "terminal"
              "nofile"
            ];
            filetypes = [
              "help"
              "alpha"
              "dashboard"
              "neo-tree"
              "Trouble"
              "trouble"
              "lazy"
              "mason"
              "notify"
              "toggleterm"
              "lazyterm"
              "nvterm"
            ];
          };
        };
      };
    };
  };
}
