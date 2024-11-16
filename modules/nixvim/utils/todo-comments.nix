{ lib, config, ... }:
{
  options = {
    utils.todo-comments.enable = lib.mkEnableOption "Enable todo-comments module";
  };
  config = lib.mkIf config.utils.todo-comments.enable {
    plugins.todo-comments = {
      enable = true;
    };
  };
}

