{
  lib,
  config,
  ...
}: {
  options = {
    completion.cmp.enable = lib.mkEnableOption "Enable cmp module";
  };

  config = lib.mkIf config.completion.cmp.enable {
    plugins = {
      luasnip.enable = true;

      cmp = {
        enable = true;
        autoEnableSources = true;

        cmdline = let
          search = {
            mapping = {__raw = "cmp.mapping.preset.cmdline()";};
            sources = [{name = "buffer";}];
          };
        in {
          "/" = search;
          "?" = search;
          ":" = {
            mapping = {__raw = "cmp.mapping.preset.cmdline()";};
            sources = [{name = "cmdline";}];
          };
        };

        settings = {
          experimental = {
            ghost_text = true;
          };
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

          sources = [
            {
              name = "nvim_lsp";
              priority = 1000;
            }
            {
              name = "luasnip";
              priority = 750;
            }
            {
              name = "neorg";
              priority = 500;
            }
            {
              name = "dictionary";
              priority = 300;
            }
            {
              name = "path";
              priority = 250;
            }
            {
              name = "buffer";
              # Words from other open buffers can also be suggested.
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              priority = 800;
            }
          ];

          mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
                ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}), -- 'c' for Cycle?
                ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
                ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
                ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }), -- change to Replace if don't like
              })
            '';
          };

          # Enable pictogram icons for lsp/autocompletion
          formatting = {
            fields = [
              "kind"
              "abbr"
              "menu"
            ];
            expandable_indicator = true;
          };
          performance = {
            debounce = 60;
            fetching_timeout = 200;
            max_view_entries = 30;
          };
          window = {
            completion = {
              border = "rounded";
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None";
            };
            documentation = {
              border = "rounded";
            };
          };
        };
      };
    };
    extraConfigLua = ''
      luasnip = require("luasnip")
      kind_icons = {
        Text = "󰊄",
        Method = "",
        Function = "󰡱",
        Constructor = "",
        Field = "",
        Variable = "󱀍",
        Class = "",
        Interface = "",
        Module = "󰕳",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      }
    '';
  };
}
