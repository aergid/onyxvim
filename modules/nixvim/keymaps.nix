{
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  keymaps = [
    # Tabs
    {
      mode = "n";
      key = "<leader>tl";
      action = "<cmd>tablast<cr>";
      options = {
        silent = true;
        desc = "Last tab";
      };
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = "<cmd>tabfirst<cr>";
      options = {
        silent = true;
        desc = "First Tab";
      };
    }
    {
      mode = "n";
      key = "<leader>tn";
      action = "<cmd>tabnew<cr>";
      options = {
        silent = true;
        desc = "New Tab";
      };
    }
    {
      mode = "n";
      key = "<leader>t]";
      action = "<cmd>tabnext<cr>";
      options = {
        silent = true;
        desc = "Next Tab";
      };
    }
    {
      mode = "n";
      key = "<leader>tc";
      action = "<cmd>tabclose<cr>";
      options = {
        silent = true;
        desc = "Close tab";
      };
    }

    {
      mode = "n";
      key = "<leader>t[";
      action = "<cmd>tabprevious<cr>";
      options = {
        silent = true;
        desc = "Previous Tab";
      };
    }

    # Windows
    # C-w-s -split horizontal
    # C-w-v -split vertical
    # C-w-x -eXchange aka swap
    # C-w-c - close
    {
      mode = "n";
      key = "<C-q>";
      action = "<C-w>c";
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-Left>";
      action = ":wincmd h<CR>";
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-Right>";
      action = ":wincmd l<CR>";
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-Down>";
      action = ":wincmd j<CR>";
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-Up>";
      action = ":wincmd k<CR>";
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<S-Up>";
      action = ":resize -2<CR>";
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<S-Down>";
      action = ":resize +2<CR>";
      options = {
        silent = true;
      };
    }{
      mode = "n";
      key = "<S-Left>";
      action = ":vertical resize +2<CR>";
      options = {
        silent = true;
      };
    }{
      mode = "n";
      key = "<S-Right>";
      action = ":vertical resize -2<CR>";
      options = {
        silent = true;
      };
    }

    # Buffers
    {
      key = "<leader>bn";
      action = ":bnext<CR>";
      options = {
        silent = true;
        desc = "Next buffer";
      };
    }
    {
      key = "<leader>bp";
      action = ":bprevious<CR>";
      options = {
        silent = true;
        desc = "Previous buffer";
      };
    }
    {
      key = "<leader>bl";
      action = ":b#<CR>";
      options = {
        silent = true;
        desc = "Last buffer";
      };
    }

    {
      mode = "n";
      key = "<C-s>";
      action = "<cmd>w<cr><esc>";
      options = {
        silent = true;
        desc = "Save file";
      };
    }


    # Toggle
    {
      mode = "n";
      key = "<leader>ul";
      action = ":lua ToggleLineNumber()<cr>";
      options = {
        silent = true;
        desc = "Toggle Line Numbers";
      };
    }
    {
      mode = "n";
      key = "<leader>uL";
      action = ":lua ToggleRelativeLineNumber()<cr>";
      options = {
        silent = true;
        desc = "Toggle Relative Line Numbers";
      };
    }
    {
      mode = "n";
      key = "<leader>uw";
      action = ":lua ToggleWrap()<cr>";
      options = {
        silent = true;
        desc = "Toggle Line Wrap";
      };
    }
    {
      mode = "n";
      key = "<leader>uh";
      action = ":lua ToggleInlayHints()<cr>";
      options = {
        silent = true;
        desc = "Toggle Inlay Hints";
      };
    }

    # Set highlight on search, but clear on pressing <Esc> in normal mode
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
    }

    {
      mode = ["n" "v"];
      key = ">";
      action = ">gv";
      options = {
        silent = true;
      };
    }
    {
      mode = ["n" "v"];
      key = "<";
      action = "<gv";
      options = {
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<TAB>";
      action = ">gv";
      options = {
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<S-TAB>";
      action = "<gv";
      options = {
        silent = true;
      };
    }

    {
      mode = "v";
      key = "<S-Up>";
      action =  ":m '<-2<CR>gv=gv";
      options = {
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<S-Down>";
      action = ":m '>+1<CR>gv=gv";
      options = {
        silent = true;
      };
    }

  ];
}
