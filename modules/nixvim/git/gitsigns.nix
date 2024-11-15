{ lib, config, ... }:
{
  options = {
    git.gitsigns.enable = lib.mkEnableOption "Enable gitsigns module";
  };

  config = lib.mkIf config.git.gitsigns.enable {
    plugins.gitsigns = {
      enable = true;
      settings = {
        trouble = (config.lsp.trouble.enable == true);
        current_line_blame = false;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>gr";
        action = ":Gitsigns reset_buffer<CR>";
        options = {
          silent = true;
          desc = "Reset buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>gr";
        action = ":Gitsigns reset_hunk<CR>";
        options = {
          silent = true;
          desc = "Reset hunk";
        };
      }
      {
        mode = "n";
        key = "<leader>gp";
        action = ":Gitsigns preview_hunk_inline<CR>";
        options = {
          silent = true;
          desc = "Preview hunk";
        };
      }
      {
        mode = "n";
        key = "<leader>ud";
        action = ":Gitsigns toggle_deleted<CR>";
        options = {
          silent = true;
          desc = "Toggle deleted lines";
        };
      }
      {
        mode = "n";
        key = "]h";
        action = ":Gitsigns next_hunk<CR>";
        options = {
          silent = true;
          desc = "Jump to next hunk";
        };
      }
      {
        mode = "n";
        key = "[h";
        action = ":Gitsigns prev_hunk<CR>";
        options = {
          silent = true;
          desc = "Jump to previous hunk";
        };
      }
    ];
  };
}

