{ helpers, lib, config, ... }:
{
  options = {
    utils.auto-session.enable = lib.mkEnableOption "Enable auto-session module";
  };

  config = lib.mkIf config.utils.auto-session.enable {
    plugins.auto-session = {
      enable = true;

      settings = {
        bypass_save_filetypes = [
          "dashboard"
          "nvim-tree"
          "neo-tree"
          "alpha"
          "netrw"
          "oil"
        ];

        pre_save_cmds = [
          "Neotree close"
          (helpers.mkRaw ''
            function()
              vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
            end
          '')
        ];
        post_restore_cmds = [
          "Neotree filesystem show"
          # "wincmd ="
        ];
      };
    };

    keymaps = [
      {
        mode = "n";
        action = "<cmd>Telescope session-lens<cr>";
        key = "<leader>fs";
        options = {
          desc = "Find Session";
        };
      }
    ];
  };
}
