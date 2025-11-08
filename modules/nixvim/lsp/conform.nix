{
  lib,
  config,
  pkgs,
  ...
}:
# Formatting plugin
{
  options = {
    lsp.conform.enable = lib.mkEnableOption "Enable conform module";
  };
  config = lib.mkIf config.lsp.conform.enable {
    extraPackages = with pkgs; [
      tree-sitter
      black
      prettierd
      stylua
      alejandra
      rustfmt
    ];

    plugins.conform-nvim = {
      enable = true;
      settings = {
        notify_on_error = true;

        format_on_save =
          # Lua
          ''
            function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end
              return { timeout_ms = 200, lsp_format = "fallback" }
            end
          '';

        formatters_by_ft = {
          html = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          css = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          javascript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          javascriptreact = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          typescript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          typescriptreact = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          python = ["black"];
          lua = ["stylua"];
          nix = ["alejandra"];
          markdown = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          rust = ["rustfmt"];
          "_" = ["trim_whitespace"];
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>uf";
        action = ":FormatToggle<CR>";
        options = {
          desc = "Toggle Format Globally";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>uF";
        action = ":FormatToggle!<CR>";
        options = {
          desc = "Toggle Format Locally";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>cf";
        action = "<cmd>lua require('conform').format()<cr>";
        options = {
          silent = true;
          desc = "Format Buffer";
        };
      }

      {
        mode = "v";
        key = "<leader>cF";
        action = "<cmd>lua require('conform').format()<cr>";
        options = {
          silent = true;
          desc = "Format Lines";
        };
      }
    ];
  };
}
