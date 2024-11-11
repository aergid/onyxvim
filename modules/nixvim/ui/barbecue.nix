{
lib,
config,
...
}:
with lib; let
  cfg = config.ui.barbecue;
in {
  options = {
    ui.barbecue.enable = mkEnableOption "Enable barbecue module";
  };
  config = mkIf cfg.enable {
    plugins.barbecue = {
      enable = true;
      # settings = {
      #   create_autocmd = false;
      #   theme = "auto";
      # };
    };
    extraConfigLua = ''
      vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include this if you have set `show_modified` to `true`
        "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    '';
  };
}
