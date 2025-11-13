{
  lib,
  pkgs,
  config,
  ...
}:
# Shows lsp progress in lower right corner
# https://github.com/j-hui/fidget.nvim
{
  options = {
    ui.fidget.enable = lib.mkEnableOption "Enable fidget module";
  };
  config = lib.mkIf config.ui.fidget.enable {
    extraPlugins = with pkgs.vimPlugins; [
      fidget-nvim
    ];

    extraConfigLua = ''
      require("fidget").setup {
        notification = {
          override_vim_notify = true,
          window = {
            winblend = 0,
          },
        },
      }
    '';
  };
}
