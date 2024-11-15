{ pkgs, lib,  ... }:
{
  vimAlias = true;
  withNodeJs = true;
  withRuby = true;

  luaLoader.enable = true;

  ui = {
    barbecue.enable = false;
    bufferline.enable = true;
    indent-blankline.enable = true;
    web-devicons.enable = true;
    notify.enable = true;
  };

  utils = {
    which-key.enable = true;
    telescope-nvim.enable = true;
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
          nvimtree = true;
          treesitter = true;
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
