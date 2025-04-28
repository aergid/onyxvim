{
  lib,
  config,
  ...
}: {
  options = {
    fs.harpoon.enable = lib.mkEnableOption "Enable harpoon module";
  };
  config = lib.mkIf config.fs.harpoon.enable {
    keymaps = [
      {
        mode = "n";
        key = "<leader>ha";
        action.__raw = "function() require'harpoon':list():add() end";
      }
      {
        mode = "n";
        key = "<C-e>";
        action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
      }
    ];

    plugins.harpoon = {
      enable = true;
      enableTelescope = true;
    };
  };
}
