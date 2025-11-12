{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    fs.neo-tree.enable = lib.mkEnableOption "Enable neo-tree module";
  };
  config = lib.mkIf config.fs.neo-tree.enable {
    extraPlugins = with pkgs.vimPlugins; [
      neo-tree-nvim
    ];

    extraConfigLua = ''
      require('neo-tree').setup({
          sources = {
            "filesystem",
            "buffers",
            "git_status",
            "document_symbols",
          },

          source_selector = {
            winbar = true,
            sources = {                                               -- table
              {
                source = "filesystem",                                -- string
                display_name = " 󰉓 Files "                            -- string | nil
              },
              {
                source = "buffers",                                   -- string
                display_name = " 󰈚 Buffers "                          -- string | nil
              },
              {
                source = "git_status",                                -- string
                display_name = " 󰊢 Git "                              -- string | nil
              },
              {
                source = "document_symbols",                                -- string
                display_name = "  Symbols "                              -- string | nil
              },

            },
          },
          auto_clean_after_session_restore = true, -- Automatically clean up broken neo-tree buffers saved in sessions
          close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
          open_files_in_last_window = false, -- false = open files in top left window
          open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" }, -- when opening files, do not use windows containing these filetypes or buftypes
          popup_border_style = "single", -- "double", "rounded", "single", "solid", (or "" to use 'winborder' on Neovim v0.11+)


          commands = {
            clear_clipboard = function(state)
              -- Define the clear_clipboard action if it's custom
              state.clipboard = {}
              print("Clipboard cleared")
            end,
          },
          window = {
            mappings = {
              ["O"] = {
                function (state)
                  local node = state.tree:get_node()
                  if require("neo-tree.utils").is_expandable(node) then
                    state.commands["toggle_node"](state)
                  else
                    state.commands['open'](state)
                    vim.cmd('Neotree reveal')
                  end
                end,
                desc = "open file or dir",
              },
              ["e"] = "noop", -- disable auto expand; it doesn't work with edgy
              ["<"] = "prev_source",
              [">"] = "next_source",
            },
          },
          buffers = {
            -- When working with sessions, for example, restored but unfocused buffers
            -- are mark as "unloaded". Turn this on to view these unloaded buffer.
            show_unloaded = true,
            terminals_first = false,  -- when true, terminals will be listed before file buffers
          },
          document_symbols = {
            follow_cursor = false,
            renderers = {
              root = {
                {"indent"},
                {"icon", default="C" },
                {"name", zindex = 10},
              },
              symbol = {
                {"indent", with_expanders = true},
                {"kind_icon", default="?" },
                {"container",
                  content = {
                    {"name", zindex = 10},
                    -- {"kind_name", zindex = 20, align = "right"},
                  }
                }
              },
            },
            window = {
              mappings = {
                ["<cr>"] = "jump_to_symbol",
                ["o"] = "jump_to_symbol",
                ["A"] = "noop", -- also accepts the config.show_path and config.insert_as options.
                ["d"] = "noop",
                ["y"] = "noop",
                ["x"] = "noop",
                ["p"] = "noop",
                ["c"] = "noop",
                ["m"] = "noop",
                ["a"] = "noop",
                ["/"] = "filter",
                ["f"] = "filter_on_submit",
              },
            },
          },
      })
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>ef";
        action = ":Neotree focus filesystem reveal<CR>:Neotree focus filesystem reveal<CR>";
        options = {
          silent = true;
          desc = "NeoTree files";
        };
      }
      # {
      #   mode = "n";
      #   key = "<leader>eg";
      #   action = ":Neotree focus git_status<CR>:Neotree focus git_status<CR>";
      #   options = {
      #     silent = true;
      #     desc = "NeoTree git";
      #   };
      # }
      {
        mode = "n";
        key = "<leader>eb";
        action = ":Neotree focus buffers<CR>:Neotree focus buffers<CR>";
        options = {
          silent = true;
          desc = "NeoTree buffers";
        };
      }
      {
        mode = "n";
        key = "<leader>es";
        action = ":Neotree document_symbols<CR>:Neotree document_symbols<CR>";
        options = {
          silent = true;
          desc = "NeoTree document_symbols<CR>";
        };
      }
    ];
  };
}
