{
  lib,
  config,
  ...
}: {
  options = {
    completion.lspkind.enable = lib.mkEnableOption "Enable lspkind module";
  };
  config = lib.mkIf config.completion.lspkind.enable {
    plugins.lspkind = {
      enable = true;
      symbolMap = {
        Copilot = "";
      };
      extraOptions = {
        maxwidth = 50;
        ellipsis_char = "...";
      };
    };
  };
}
