{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {ui.lualine.enable = lib.mkEnableOption "Enable lualine module";};

  config = lib.mkIf config.ui.lualine.enable {
    extraPlugins = with pkgs.vimPlugins; [
      lualine-nvim
    ];

    extraConfigLua = ''
      require('lualine').setup({
        options = {
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = ""},
          ignore_focus = { "edgy", "neo-tree" },
          disabled_filetypes = {
            statusline = { "neo-tree" },
            winbar = { "neo-tree" },
          },
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', '', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {
          lualine_a = { { "mode", color = { gui = "bold" } } }, -- mode at left
          lualine_b = { "branch" },                             -- git branch
          lualine_c = {
            -- filename with relative path
            { "filename", path = 1, shorting_target = 40 },
          },
          lualine_x = {
            -- diagnostics (nvim_lsp) and optionally navic breadcrumbs
            { "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
            -- maybe(navic_location),
          },
          lualine_y = { "filetype" },
          lualine_z = { "location" }, -- line:col / percent
        },

        inactive_winbar = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { "filename", path = 1 } },
          -- lualine_x = { maybe(navic_location) },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "fzf", "neo-tree" }
      })
    '';
  };
}
