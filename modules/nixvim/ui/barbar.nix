{ lib, config, ... }: 
{
  options = { ui.barbar.enable = lib.mkEnableOption "Enable  module"; };

  config = lib.mkIf config.ui.barbar.enable {
    plugins.barbar = {
      enable = true;

      settings = {
        animation = true;
        tabpages = true;
        clickable = true;
        highlight_alternate = true;
        insert_at_end = true;
        focus_on_close = "previous";
        sidebar_filetypes = {
           neo-tree = {
            event = "BufWipeout";
            text = "neo-tree"; 
            align = "left";
          };
        };
        exclude_ft = [
          "oil"
          "qf"
          "fugitive"
        ];
        exclude_name = [
        ];
        icons = {
          button ="";
          separator_at_end = true;
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<Tab>";
        action ="<Cmd>BufferPrevious<CR>";
        options = {
          desc = "Cycle to next buffer";
        };
      }

      {
        mode = "n";
        key = "<S-Tab>";
        action = "<Cmd>BufferNext<CR>";
        options = {
          desc = "Cycle to previous buffer";
        };
      }

      {
        mode = "n";
        key = "<leader>bu";
        action = "<cmd>BufferRestore<cr>";
        options = {
          desc = "Delete Restore";
        };
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>BufferClose<cr>";
        options = {
          desc = "Delete buffer";
        };
      }

      {
        mode = "n";
        key = "<leader>bb";
        action = "<cmd>b#<cr>";
        options = {
          desc = "Switch to Other Buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>br";
        action = "<cmd>BufferCloseBuffersLeft<cr>";
        options = {
          desc = "Delete buffers to the right";
        };
      }

      {
        mode = "n";
        key = "<leader>bl";
        action = "<cmd>BufferCloseBuffersRight<cr>";
        options = {
          desc = "Delete buffers to the left";
        };
      }

      {
        mode = "n";
        key = "<leader>bo";
        action = "<cmd>BufferCloseAllButCurrentOrPinned<cr>";
        options = {
          desc = "Delete other buffers";
        };
      }

      {
        mode = "n";
        key = "<leader>bp";
        action = "<cmd>BufferPin<cr>";
        options = {
          desc = "Toggle pin";
        };
      }

      {
        mode = "n";
        key = "<leader>bP";
        action = "<Cmd>BufferCloseAllButPinned<CR>";
        options = {
          desc = "Delete non-pinned buffers";
        };
      }
    ];
  };
}

