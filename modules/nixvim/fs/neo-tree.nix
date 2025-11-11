{
  lib,
  config,
  ...
}: {
  options = {
    fs.neo-tree.enable = lib.mkEnableOption "Enable neo-tree module";
  };
  config = lib.mkIf config.fs.neo-tree.enable {
    plugins.neo-tree = {
      enable = true;
      settings = {
        enableDiagnostics = true;
        enableGitStatus = true;
        enableModifiedMarkers = true;
        enableRefreshOnWrite = true;
        closeIfLastWindow = true;
        # open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy"};
        openFilesDoNotReplaceTypes = ["terminal" "Trouble" "qf" "edgy"];
        popupBorderStyle = "rounded"; # Type: null or one of “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code
        buffers = {
          bindToCwd = false;
          followCurrentFile = {
            enabled = true;
          };
        };
        sources = [
          "filesystem"
          "buffers"
          "git_status"
          "document_symbols"
        ];
        window = {
          # position = "current";
          mappings = {
            e.__raw = ''nil'';
            Z = "expand_all_nodes";
            O.__raw = ''
              function (state)
                local node = state.tree:get_node()
                if require("neo-tree.utils").is_expandable(node) then
                  state.commands["toggle_node"](state)
                else
                  state.commands['open'](state)
                  vim.cmd('Neotree reveal')
                end
              end
            '';
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>et";
        action = ":Neotree toggle reveal_force_cwd<cr>";
        options = {
          silent = true;
          desc = "NeoTree (root dir)";
        };
      }
      {
        mode = "n";
        key = "<leader>er";
        action = ":Neotree action=focus reveal<CR>";
        options = {
          silent = true;
          desc = "NeoTree reveal file";
        };
      }
      {
        mode = "n";
        key = "<leader>eg";
        action = ":Neotree git_status<CR>";
        options = {
          silent = true;
          desc = "Git explorer";
        };
      }
    ];
  };
}
