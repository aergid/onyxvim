{ lib, config, ... }:
{
  options = {
    fs.neo-tree.enable = lib.mkEnableOption "Enable neo-tree module";
  };
  config = lib.mkIf config.fs.neo-tree.enable {

    plugins.neo-tree = {
      enable = true;
      enableDiagnostics = true;
      enableGitStatus = true;
      enableModifiedMarkers = true;
      enableRefreshOnWrite = true;
      closeIfLastWindow = true;
      popupBorderStyle = "rounded"; # Type: null or one of “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code
      buffers = {
        bindToCwd = false;
        followCurrentFile = {
          enabled = true;
        };
      };
      # sources = [
      #   "filesystem"
      #   "git_status"
      # ];
      window = {
        width = 40;
        height = 15;
        autoExpandWidth = false;
        mappings = {
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

    keymaps = [
      {
        mode = "n";
        key = "<leader>nt";
        action = ":Neotree toggle reveal_force_cwd<cr>";
        options = {
          silent = true;
          desc = "Explorer NeoTree (root dir)";
        };
      }
      {
        mode = "n";
        key = "<leader>nT";
        action = "<cmd>Neotree toggle<CR>";
        options = {
          silent = true;
          desc = "Explorer NeoTree (cwd)";
        };
      }
      {
        mode = "n";
        key = "<leader>nr";
        action = ":Neotree action=focus reveal<CR>";
        options = {
          silent = true;
          desc = "Explorer NeoTree focus on file";
        };
      }
      {
        mode = "n";
        key = "<leader>ng";
        action = ":Neotree git_status<CR>";
        options = {
          silent = true;
          desc = "Git explorer";
        };
      }
    ];
  };
}

