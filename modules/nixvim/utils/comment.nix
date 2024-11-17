{
  lib,
  config,
  ...
}: {
  options = {
    utils.comment.enable = lib.mkEnableOption "Enable comment module";
  };

  config = lib.mkIf config.utils.comment.enable {
    plugins.comment = {
      enable = true;
    };
  };
}
