{
  clipboard = {
    # Use system clipboard
    register = "unnamedplus";
    providers.wl-copy.enable = true;
  };

  waylandSupport = false;

  opts = {
    sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals";
    updatetime = 50; # Faster completion

    # diff related
    diffopt = "internal,filler,closeoff,algorithm:patience,linematch:60";
    fillchars = "diff:\ ";

    # Tab and lines options
    tabstop = 2; # Number of spaces a <Tab> in the text stands for (local to buffer)
    shiftwidth = 2; # Number of spaces used for each step of (auto)indent (local to buffer)
    expandtab = true; # Expand <Tab> to spaces in Insert mode (local to buffer)
    wrap = false;
    linebreak = true;
    breakindent = true;
    textwidth = 0; # Maximum width of text that is being inserted.  A longer line will be broken after white space to get this width.
    autoindent = true; # Do clever autoindenting

    # Folding
    foldcolumn = "0";
    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;

    # Line numbers
    relativenumber = true;
    number = true;
    hidden = true; # Keep closed buffer open in the background
    mouse = "a"; # Enable mouse control
    mousemodel = "extend"; # Mouse right-click extends the current selection

    # Default splitting will cause your main splits to jump when opening an edgebar.
    # To prevent this, set `splitkeep` to either `screen` or `topline`.
    splitkeep = "screen";
    splitbelow = true; # A new window is put below the current one
    splitright = true; # A new window is put right of the current one

    swapfile = false; # Disable the swap file
    modeline = true; # Tags such as 'vim:ft=sh'
    modelines = 100; # Sets the type of modelines
    undofile = true; # Automatically save and restore undo history
    backup = false;

    incsearch = true; # Incremental search: show match for partly typed search command
    inccommand = "split"; # Search and replace: preview changes in quickfix list
    ignorecase = true; # When the search query is lower-case, match both lower and upper-case patterns
    smartcase = true; # Override the 'ignorecase' option if the search pattern contains upper case characters

    scrolloff = 6; # Number of screen lines to show around the cursor
    cursorline = false; # Highlight the screen line of the cursor
    cursorcolumn = false; # Highlight the screen column of the cursor
    signcolumn = "yes:1"; # Whether to show the signcolumn
    colorcolumn = "0"; # Columns to highlight
    laststatus = 3; # When to use a status line for the last window
    fileencoding = "utf-8"; # File-content encoding for the current buffer
    termguicolors = true; # Enables 24-bit RGB color in the |TUI|
    spell = false; # Highlight spelling mistakes (local to window)
  };
}
