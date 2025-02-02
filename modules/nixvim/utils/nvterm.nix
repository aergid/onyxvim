{pkgs, ...}: {
  config = {
    extraPlugins = [
      pkgs.vimPlugins.nvterm
    ];
    extraConfigLua = ''
      require("nvterm").setup({
      	terminals = {
      		shell = vim.o.shell,
      		list = {},
      		type_opts = {
      			float = {
      				relative = "editor",
      				row = 0.1,
      				col = 0.1,
      				width = 0.8,
      				height = 0.8,
      				border = "rounded",
      			},
      			horizontal = { location = "rightbelow", split_ratio = 0.5 },
      			vertical = { location = "rightbelow", split_ratio = 0.5 },
      		},
      	},
      	behavior = {
      		autoclose_on_quit = {
      			enabled = false,
      			confirm = true,
      		},
      		close_on_exit = true,
      		auto_insert = true,
      	},
      })
      local terminal = require("nvterm.terminal")

      local toggle_modes = { "n", "t" }
      local mappings = {
      	{
      		toggle_modes,
      		"<leader>,",
      		function()
      			terminal.toggle("float")
      		end,
      	},
      	{
      		toggle_modes,
      		"<A-h>",
      		function()
      			terminal.toggle("horizontal")
      		end,
      	},
      	{
      		toggle_modes,
      		"<A-v>",
      		function()
      			terminal.toggle("vertical")
      		end,
      	},
      	{
      		toggle_modes,
      		"<A-f>",
      		function()
      			terminal.toggle("float")
      		end,
      	},
      }
      local opts = { noremap = true, silent = true }
      for _, mapping in ipairs(mappings) do
      	vim.keymap.set(mapping[1], mapping[2], mapping[3], mapping[4], opts)
      end
    '';
  };
}
