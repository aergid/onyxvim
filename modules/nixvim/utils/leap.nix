{
  lib,
  config,
  ...
}: {
  options = {
    utils.leap.enable = lib.mkEnableOption "Enable leap module";
  };

  config = lib.mkIf config.utils.leap.enable {
    plugins.leap = {
      enable = true;
    };
  };
}
