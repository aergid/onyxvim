{ pkgs, lib,  ... }:
{
  vimAlias = true;
  withNodeJs = true;
  withRuby = true;

  luaLoader.enable = true;

  ui = {
    alpha.enable = lib.mkDefault true;
    barbecue.enable = true;
    indent-blankline.enable = true;
    web-devicons.enable = false;
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-bufkill
  ];

}
