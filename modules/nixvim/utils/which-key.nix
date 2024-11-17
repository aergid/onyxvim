{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    utils.which-key.enable = lib.mkEnableOption "Enable which-key module";
  };

  config = lib.mkIf config.utils.which-key.enable {
    extraPackages = with pkgs; [ripgrep];
    plugins.which-key = {
      enable = true;
      settings = {
        icons = {
          breadcrumb = "»";
          group = "+";
          separator = ""; # ➜
        };
        spec = [
          # Harpoon Configs
          {
            __unkeyed-1 = "<leader>h";
            mode = "n";
            group = "+harpoon";
            icon = "󱡁";
          }
          {
            __unkeyed-1 = "<leader>ha";
            mode = "n";
            group = "Add file to Harpoon";
          }
          {
            __unkeyed-1 = "<leader>hn";
            mode = "n";
            group = "Harpoon File 1";
          }
          {
            __unkeyed-1 = "<leader>he";
            mode = "n";
            group = "Harpoon File 2";
          }
          {
            __unkeyed-1 = "<leader>hi";
            mode = "n";
            group = "Harpoon File 3";
          }
          {
            __unkeyed-1 = "<leader>ho";
            mode = "n";
            group = "Harpoon File 4";
          }

          # General Mappings
          {
            __unkeyed-1 = "<leader>c";
            mode = [
              "n"
              "v"
            ];
            group = "+code";
          }
          {
            __unkeyed-1 = "<leader>d";
            mode = [
              "n"
              "v"
            ];
            group = "+debug";
          }
          {
            __unkeyed-1 = "<leader>b";
            mode = "n";
            group = "+buffer";
          }
          {
            __unkeyed-1 = "<leader>f";
            mode = "n";
            group = "+find/file";
          }

          {
            __unkeyed-1 = "<leader>g";
            mode = [
              "n"
              "v"
            ];
            group = "+git";
          }

          {
            __unkeyed-1 = "<leader>s";
            mode = "n";
            group = "+search";
          }
          {
            __unkeyed-1 = "<leader>t";
            mode = "n";
            group = "+tab";
          }
          {
            __unkeyed-1 = "<leader>u";
            mode = "n";
            group = "+ui";
          }
          {
            __unkeyed-1 = "<leader>e";
            mode = "n";
            group = "+explorer";
          }
          {
            __unkeyed-1 = "<leader>n";
            mode = "n";
            group = "+neorg";
          }
        ];
        win = {
          border = "none";
          wo.winblend = 0;
        };
      };
    };
  };
}
