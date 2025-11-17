local map = require("custom.core.utils").map

map("i", "jk", "<Esc>")

-- `kanata`: disable typing accented characters
-- `:h digraph`
map("i", "<C-k>", "<Esc>")

-- map("n", "<space>", "<Nop>")
-- map("x", "<space>", "<Nop>")
--
-- map("n", "[[", "<Nop>")
-- map("n", "]]", "<Nop>")
-- map("n", ")", "<Nop>")
-- map("n", "(", "<Nop>")
--
-- map("n", "<C-j>", "<Nop>")
-- map("n", "<C-k>", "<Nop>")
--
-- map("n", "<C-t>", "<Nop>")
-- map("n", "<C-e>", "<Nop>")

-- avoid accidents for keymappings
map("n", "<leader>x", "<Nop>")
map("n", "<leader>d", "<Nop>")
map("n", "<leader>c", "<Nop>")
map("n", "<leader>y", "<Nop>")
map("n", "<leader>k", "<Nop>")
map("n", "<leader>f", "<Nop>")
map("n", "<leader>r", "<Nop>")
map("n", "<leader>l", "<Nop>")
map("n", "<leader>t", "<Nop>")
map("n", "<leader>m", "<Nop>")
map("n", "<leader>g", "<Nop>")
map("n", "<leader>s", "<Nop>")
map("n", "<leader>a", "<Nop>")

-- disable unused keys
-- map("n", "<C-y>", "<Nop>")
-- map("n", "<S-h>", "<Nop>")
-- map("n", "<S-l>", "<Nop>")
--
-- map("n", "<C-z>", "<Nop>")
-- map("i", "<C-z>", "<Nop>")
-- map("v", "<C-z>", "<Nop>")

-- avoid command history
map("n", "q:", ":q<cr>")
-- no `q` for macro
map("n", "q", "<nop>")
-- map("n", "ZZ", "<nop>")

-- no replace mode
map("n", "gR", "<nop>")

-- no rot13 encoding
map("n", "g??", "<nop>")
map("n", "g?g?", "<nop>")

map("i", "<C-c>", "<Esc>")

-- operate on display lines rather than real lines
map("n", "k", "gk")
map("n", "j", "gj")
map("x", "k", "gk")
map("x", "j", "gj")

-- select 5 lines in visual mode
map("x", "J", "5j")
map("x", "K", "5k")

-- backspace to black hole registry
-- map("n", "<BS><BS>", '"_')
-- map("x", "<BS><BS>", '"_')
-- map("v", "<BS><BS>", '"_')

-- undo break points in insert mode
-- map("i", ",", ",<C-g>u")
-- map("i", ".", ".<C-g>u")
-- map("i", "!", "!<C-g>u")
-- map("i", "?", "?<C-g>u")
-- map("i", "[", "[<C-g>u")

-- don't copy replaced text after pasting
vim.keymap.set("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

-- yank till end of line
map("n", "Y", "y$")
