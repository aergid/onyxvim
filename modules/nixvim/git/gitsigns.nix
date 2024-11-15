{ lib, config, ... }:
{
  options = {
    git.gitsigns.enable = lib.mkEnableOption "Enable gitsigns module";
    utils.trouble.enable = lib.mkEnableOption "Enable trouble module";
  };

  config = lib.mkIf config.git.gitsigns.enable {
    plugins.gitsigns = {
      enable = true;
      settings = {
        trouble = (config.utils.trouble.enable == true);
        current_line_blame = false;
      };
    };
    keymaps = [
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

