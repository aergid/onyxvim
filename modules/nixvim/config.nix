{
  pkgs,
  lib,
  ...
}: {
  vimAlias = true;
  withNodeJs = true;
  withRuby = true;

  luaLoader.enable = true;

  ui = {
    barbecue.enable = false;
    bufferline.enable = false;
    barbar.enable = true;
    indent-blankline.enable = true;
    web-devicons.enable = true;
    notify.enable = true;
    lualine.enable = true;
  };

  utils = {
    auto-session.enable = true;
    which-key.enable = true;
    telescope-nvim.enable = true;
    todo-comments.enable = true;
  };

  fs = {
    oil.enable = true;
    harpoon.enable = true;
    neo-tree.enable = true;
  };

  git = {
    neogit.enable = true;
    gitsigns.enable = true;
    diffview.enable = true;
  };

  languages = {
    treesitter-nvim.enable = true;
  };

  lsp = {
    conform.enable = true;
    fidget.enable = true;
    lsp-nvim.enable = true;
    lspsaga.enable = true;
    trouble.enable = true;
    none-ls-nvim.enable = false;
  };

  completion = {
    cmp.enable = true;
    lspkind.enable = true;
  };

  colorscheme = "catppuccin";
  colorschemes = {
    catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        term_colors = true;
        integrations = {
          cmp = true;
          gitsigns = true;
          indent_blankline = {enabled = true;};
          leap = true;
          lsp_trouble = true;
          treesitter = true;
          markdown = true;
          mini = true;
          native_lsp = {
            enabled = true;
            underlines = {
              errors = ["undercurl"];
              hints = ["undercurl"];
              warnings = ["undercurl"];
              information = ["undercurl"];
            };
          };
          navic = {
            enabled = true;
            custom_bg = "lualine";
          };
          neotest = true;
          neotree = true;
          noice = true;
          notify = true;
          semantic_tokens = true;
          telescope = true;
          treesitter_context = true;
          which_key = true;
        };
        dim_inactive = {
          enabled = true;
          percentage = 0.15;
        };
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
  ];
}
