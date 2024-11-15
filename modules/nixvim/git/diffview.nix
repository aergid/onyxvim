{ lib, config, ... }:
{
  options = {
    git.diffview.enable = lib.mkEnableOption "Enable diffview module";
  };
  config = lib.mkIf config.git.diffview.enable {

    plugins.diffview = {
      enable = true;
    };
  };
}

