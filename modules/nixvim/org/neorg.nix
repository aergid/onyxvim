{
  lib,
  config,
  ...
}: {
  options = {
    org.neorg.enable = lib.mkEnableOption "Enable neorg module";
  };

  config = lib.mkIf config.org.neorg.enable {
    files."after/ftplugin/norg.lua" = {
      localOpts.conceallevel = 3;

      keymaps = [
        {
          mode = "n";
          key = "<leader>uc";
          action = ":Neorg toggle-concealer<CR>";
          options.silent = true;
          options.desc = "Neorg toggle-concealer";
        }
        {
          mode = "n";
          key = "<C-g>";
          action = ":Neorg toc<CR>";
          options.silent = true;
          options.desc = "Neorg TOC";
        }
      ];
    };

    plugins = {
      neorg = {
        enable = true;
        # lazyLoading = true;

        modules = {
          # Actually enables submodules with defaults
          "core.defaults".__empty = null;
          "core.concealer".__empty = null;
          "core.completion".config.engine = "nvim-cmp";
          "core.qol.toc".config.close_after_use = true;
          "core.summary".__empty = null;
          "core.itero".__empty = null;
          "core.ui.calendar".__empty = null;
          "core.promo".__empty = null;
          "core.pivot".__empty = null;
          "core.export".__empty = null;
          "core.integrations.treesitter".__empty = null;
          # "core.integrations.telescope".__empty = null;

          "core.esupports.metagen".config = {
            type = "auto";
            update_date = true;
          };

          "core.export.markdown".config = {
            extension = "md";
            extensions = "all";
          };

          # "core.keybinds".config = {
          #   default_keybinds = false;
          # };
          "core.keybinds".config.hook.__raw = ''
            function(keybinds)
              keybinds.unmap('norg', 'n', '<C-s>')
            end
          '';

          "core.dirman" = {
            config = {
              workspaces = {
                home = "~/Notes/home";
                work = "~/Notes/work";
              };
              default_workspace = "home";
            };
          };
        };
      };
    };

    # autoCmd = [
    # {
    #   event = "FileType";
    #   pattern = "nix";
    #   command = "setlocal tabstop=2 shiftwidth=2";
    # }
    # ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>nt";
        action = ":Neorg journal today<CR>";
        options.silent = true;
        options.desc = "Neorg journal today";
      }
      {
        mode = "n";
        key = "<leader>ny";
        action = ":Neorg journal yesterday<CR>";
        options.silent = true;
        options.desc = "Neorg journal yesterday";
      }
      {
        mode = "n";
        key = "<leader>np";
        action = ":Neorg journal custom<CR>";
        options.silent = true;
        options.desc = "Neorg journal pick";
      }
      {
        mode = "n";
        key = "<leader>nh";
        action = ":Neorg workspace home<CR>";
        options.silent = true;
        options.desc = "Neorg workspace home";
      }
      {
        mode = "n";
        key = "<leader>nw";
        action = ":Neorg workspace work<CR>";
        options.silent = true;
        options.desc = "Neorg workspace work";
      }
    ];
  };
}
