{
  lib,
  config,
  ...
}: {
  options = {
    fs.oil.enable = lib.mkEnableOption "Enable oil module";
  };
  config = lib.mkIf config.fs.oil.enable {
    plugins.oil = {
      enable = true;
      settings = {
        deleteToTrash = true;
        useDefaultKeymaps = true;
        viewOptions = {
          showHidden = true;
        };
        preview = {
          border = "rounded";
          win_options = {
            winblend = 0;
          };
        };

        float = {
          padding = 2;
          maxWidth = 0; # ''math.ceil(vim.o.lines * 0.8 - 4)'';
          maxHeight = 0; # ''math.ceil(vim.o.columns * 0.8)'';
          border = "rounded"; # 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
          winOptions = {
            winblend = 0;
          };
        };
        keymaps = {
          "?" = "actions.show_help";
          "<CR>" = "actions.select";
          "<C-v>" = "actions.select_vsplit";
          "<C-s>" = "actions.select_split"; # this is used to navigate left
          "<C-t>" = "actions.select_tab";
          "<C-p>" = "actions.preview";
          "<C-c>" = "actions.close";
          "<C-r>" = "actions.refresh";
          "<Backspace>" = "actions.parent";
          "_" = "actions.open_cwd";
          "`" = "actions.cd";
          "~" = "actions.tcd";
          "gs" = "actions.change_sort";
          "gx" = "actions.open_external";
          "g." = "actions.toggle_hidden";
          "q" = "actions.close";
        };
      };
    };
    # keymaps = [
    #   {
    #     mode = "n";
    #     key = "<leader>e";
    #     action = ":Oil --float<CR>";
    #     options = {
    #       desc = "Open parent directory";
    #       silent = true;
    #     };
    #   }
    # ];
  };
}
