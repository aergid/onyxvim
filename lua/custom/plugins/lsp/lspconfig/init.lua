return {
  {
    "nvim-lspconfig",
    event = "FileType",
    after = function(plugin)
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      if nixCats("nvim-cmp") then
        local capabilities = vim.tbl_deep_extend(
          "force",
          vim.lsp.protocol.make_client_capabilities(),
          require("cmp_nvim_lsp").default_capabilities()
        )
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        vim.lsp.config("*", {
          capabilities = capabilities,
        })
      end
      -- Tell the server the capability of foldingRange that Neovim hasn't added foldingRange to default capabilities
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      --  jsonls {{{
      vim.lsp.config.jsonls = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      }
      vim.lsp.enable("jsonls")
      -- }}}

      -- 2. lua_ls
      vim.lsp.config.lua_ls = {
        Lua = {
          runtime = { version = "LuaJIT" },
          format = { enable = false },
          telemetry = { enable = false },
          diagnostics = {
            -- recognize global objects
            globals = { "vim", "P", "Snacks", "nixCats" },
            disable = { "missing-fields" },
          },
        },
        filetypes = { "lua" },
      }
      vim.lsp.enable("lua_ls")

      -- 3. cssls
      vim.lsp.config.cssls = {
        settings = {
          css = { lint = { unknownAtRules = "ignore" } },
          scss = { lint = { unknownAtRules = "ignore" } },
          less = { lint = { unknownAtRules = "ignore" } },
        },
      }
      vim.lsp.enable("cssls")

      -- 4. pyright
      vim.lsp.config.pyright = {
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { "*" },
            },
          },
        },
      }
      vim.lsp.enable("pyright")

      -- 5. yamlls
      vim.lsp.config.yamlls = {
        settings = {
          yaml = {
            schemaStore = {
              -- disable built-in schemaStore support to use `SchemaStore.nvim`
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      }
      vim.lsp.enable("yamlls")

      -- 6. nixd
      vim.lsp.config.nixd = {
        nixd = {
          nixpkgs = {
            -- nixd requires some configuration in flake based configs.
            expr = [[import (builtins.getFlake "]] .. nixCats.extra("nixdExtras.nixpkgs") .. [[") { }   ]],
          },
          formatting = {
            command = { "nixfmt" },
          },
          diagnostic = {
            suppress = {
              "sema-escaping-with",
            },
          },
        },
      }
      vim.lsp.enable("nixd")

      -- go {{{
      gopls = {
        autostart = true,
        settings = {
          usePlaceholders = true,
          gofumpt = true,
          analyses = {
            unusedparams = true,
            unreachable = true,
          },
          staticcheck = true,
        },
      }

      --  }}}
      vim.lsp.enable("gopls")
    end,
  },
  {
    "fidget.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("fidget").setup({})
    end,
  },
  {
    -- providing access to the SchemaStore catalog
    "SchemaStore.nvim",
    lazy = false,
    dep_of = { "nvim-lspconfig" },
  },
}
