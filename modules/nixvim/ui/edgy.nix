{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {ui.edgy.enable = lib.mkEnableOption "Enable edgy module";};

  config = lib.mkIf config.ui.edgy.enable {
    extraPlugins = with pkgs.vimPlugins; [
      edgy-nvim
    ];

    extraConfigLua = ''
          require("edgy").setup({
            bottom = {
          -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
          {
            ft = "toggleterm",
            size = { height = 0.4 },
            -- exclude floating windows
            filter = function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end,
          },
          {
            ft = "lazyterm",
            title = "LazyTerm",
            size = { height = 0.4 },
            filter = function(buf)
              return not vim.b[buf].lazyterm_cmd
            end,
          },
          "Trouble",
          { ft = "qf", title = "QuickFix" },
          {
            ft = "help",
            size = { height = 20 },
            -- only show help buffers
            filter = function(buf)
              return vim.bo[buf].buftype == "help"
            end,
          },
          { ft = "spectre_panel", size = { height = 0.4 } },
        },
        left = {
          -- Neo-tree filesystem always takes half the screen height
          {
            title = "Neo-Tree",
            ft = "neo-tree",
            filter = function(buf)
              return vim.b[buf].neo_tree_source == "filesystem"
            end,
            size = { height = 0.4 },
            pinned = true,
            open = "Neotree position=left filesystem",
          },
          {
            title = "Neo-Tree Symbols",
            ft = "neo-tree",
            size = { height = 0.2 },
            filter = function(buf)
              return vim.b[buf].neo_tree_source == "document_symbols"
            end,
            pinned = true,
            -- collapsed = true, -- show window as closed/collapsed on start
            open = "Neotree position=top document_symbols",
          },
          {
            title = "Neo-Tree Buffers",
            ft = "neo-tree",
            size = { height = 0.2 },
            filter = function(buf)
              return vim.b[buf].neo_tree_source == "buffers"
            end,
            pinned = true,
            -- collapsed = true, -- show window as closed/collapsed on start
            open = "Neotree position=right buffers",
          },
          -- {
          --   title = "Neo-Tree Git",
          --   ft = "neo-tree",
          --   size = { height = 0.2 },
          --   filter = function(buf)
          --     return vim.b[buf].neo_tree_source == "git_status"
          --   end,
          --   pinned = true,
          --   -- collapsed = true, -- show window as closed/collapsed on start
          --   open = "Neotree position=right git_status";
          -- },
        },
      })
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>etl";
        action = ":lua require(\"edgy\").toggle(\"left\")<CR>";
        options = {
          silent = true;
          desc = "Toggle left pane";
        };
      }
    ];
  };
}
