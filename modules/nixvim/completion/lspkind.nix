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
      settings = {
        symbolMap = {
          Copilot = "";
        };
        maxwidth = 50;
        ellipsis_char = "...";
        # lspkind integration with cmp
        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
            neorg = "[neorg]";
          };
        };
      };
    };
  };
}
