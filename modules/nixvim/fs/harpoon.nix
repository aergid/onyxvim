{ lib, config, ... }:
{
  options = {
    fs.harpoon.enable = lib.mkEnableOption "Enable harpoon module";
  };
  config = lib.mkIf config.fs.harpoon.enable {
    plugins.harpoon = {
      enable = true;
      enableTelescope = true;
      keymapsSilent = true;
      keymaps = {
        addFile = "<leader>ha";
        toggleQuickMenu = "<C-e>";
        navFile = {
          "1" = "<leader>hn";
          "2" = "<leader>he";
          "3" = "<leader>hi";
          "4" = "<leader>ho";
        };
      };
    };
  };
}

