{
  lib,
  config,
  ...
}: {
  options = {
    utils.zen-mode.enable = lib.mkEnableOption "Enable zen-mode module";
  };

  config = lib.mkIf config.utils.zen-mode.enable {
    keymaps = [
      {
        mode = "n";
        key = "<leader>uz";
        action = ":ZenMode<CR>";
        options = {
          silent = true;
          desc = "Toggle Zen-mode";
        };
      }
    ];

    plugins.zen-mode = {
      enable = true;

      settings = {
        # on_close = ''
        #   function()
        #   end
        # '';
        # on_open = ''
        #   function()
        #   end
        # '';
        plugins = {
          # gitsigns = {
          #   enabled = true;
          # };
          # options = {
          #   enabled = true;
          #   ruler = false;
          #   showcmd = false;
          # };
          # tmux = {
          #   enabled = false;
          # };
          # twilight = {
          #   enabled = false;
          # };
        };
        window = {
          backdrop = 0.90;
          height = 1;
          options = {
            # signcolumn = "no";
          };
          width = 0.6;
        };
      };
    };
  };
}
