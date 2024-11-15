{ lib, config, ... }:
{
  options = {
    git.neogit.enable = lib.mkEnableOption "Enable neogit module";
  };
  config = lib.mkIf config.git.neogit.enable {
    plugins.neogit = {
      enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>Neogit<CR>";
        options = {
          desc = "Neogit";
        };
      }
    ];
  };
}

