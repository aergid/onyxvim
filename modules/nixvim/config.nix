{ pkgs, lib,  ... }:
{

  config =
    {
      vimAlias = true;
      withNodeJs = true;
      withRuby = true;

      luaLoader.enable = true;

      extraPlugins = with pkgs.vimPlugins; [
        vim-bufkill
      ];

      ui = {
        alpha.enable = lib.mkDefault true;
        barbecue.enable = true;
        indent-blankline.enable = true;
        web-devicons.enable = false;
      };
    };
}
