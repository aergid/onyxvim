{
  lib,
  config,
  ...
}: {
  options = {
    org.neorg.enable = lib.mkEnableOption "Enable neorg module";
  };

  config = lib.mkIf config.org.neorg.enable {
    plugins = {
      neorg.enable = true;

      modules = {
        "core.defaults".__empty = null;

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

        "core.concealer".__empty = null;
        "core.completion".config.engine = "nvim-cmp";
        "core.qol.toc".config.close_after_use = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>mt";
        action = ":Neorg journal today<CR>";
        options.silent = true;
        options.desc = "Neorg journal today";
      }
      {
        mode = "n";
        key = "<leader>my";
        action = ":Neorg journal yesterday<CR>";
        options.silent = true;
        options.desc = "Neorg journal yesterday";
      }
      {
        mode = "n";
        key = "<leader>my";
        action = ":Neorg journal custom<CR>";
        options.silent = true;
        options.desc = "Neorg journal pick";
      }
      {
        mode = "n";
        key = "<leader>mh";
        action = ":Neorg workspace home<CR>";
        options.silent = true;
        options.desc = "Neorg workspace home";
      }
      {
        mode = "n";
        key = "<leader>mw";
        action = ":Neorg workspace work<CR>";
        options.silent = true;
        options.desc = "Neorg workspace work";
      }
    ];
  };
}
