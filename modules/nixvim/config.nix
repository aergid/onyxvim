{ pkgs, lib,  ... }:
{
  vimAlias = true;
  withNodeJs = true;
  withRuby = true;

  luaLoader.enable = true;

  ui = {
    barbecue.enable = false;
    indent-blankline.enable = true;
    web-devicons.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-bufkill
  ];

}
