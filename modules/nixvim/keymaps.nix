{ lib, ... }:
let
  mkKeymaps = lib.onyxvim.keymaps.silent;

  normal = [
    {
      key = "<leader>ch";
      action = "<cmd>noh<cr>";
      options.desc = "Clear highlight";
    }
    {
      key = "<leader>cs";
      action = ''<cmd>let @/=""<cr>'';
      options.desc = "Clear search";
    }
    {
      key = "<leader>bd";
      action = "<cmd>:BD<cr>";
      options.desc = "Next buffer";
    }
    {
      key = "<leader>bp";
      action = "<cmd>:bprevious<cr>";
      options.desc = "Previous buffer";
    }
    {
      key = "<C-o>";
      action = ''<C-\><C-n>'';
      options.desc = "Exit terminal mode";
    }
  ];
in
{
  keymaps = mkKeymaps.normal normal;
}
