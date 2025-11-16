inputs: let
  inherit (inputs.nixCats) utils;
in
  {
    pkgs,
    settings,
    categories,
    name,
    extra,
    mkNvimPlugin,
    ...
  } @ packageDef: {
    # to define and use a new category, add a new list to a set here,
    # and include `categoryname = true;` in `packageDefinitions.nvim.categories`
    # NOTE: :help nixCats.flake.outputs.packageDefinitions

    environmentVariables = {
      test = {
        ONYXVIM_TEST = "It worked!";
      };
    };
    sharedLibraries = {};
    extraWrapperArgs = {};

    # python.withPackages or lua.withPackages
    # vim.g.python3_host_prog
    # :!nvim-python3
    extraPython3Packages = {
      python = py: [
        # NOTE: check disabled globally for nvim because they take SO LONG
        (py.debugpy.overrideAttrs {
          doCheck = false;
          doInstallCheck = false;
          pytestCheckPhase = "";
          installCheckPhase = "";
        })
        (py.pylsp-mypy.overrideAttrs {
          doCheck = false;
          doInstallCheck = false;
          pytestCheckPhase = "";
          installCheckPhase = "";
        })
        (py.pyls-isort.overrideAttrs {
          doCheck = false;
          doInstallCheck = false;
          pytestCheckPhase = "";
          installCheckPhase = "";
        })
        # py.python-lsp-server
        # py.python-lsp-black
        (py.pytest.overrideAttrs {
          doCheck = false;
          doInstallCheck = false;
          pytestCheckPhase = "";
          installCheckPhase = "";
        })
        # py.pylint
        # python-lsp-ruff
        # pyls-flake8
        # pylsp-rope
        # yapf
        # autopep8
        # py.google-generativeai
      ];
    };

    # populates $LUA_PATH and $LUA_CPATH
    extraLuaPackages = {
      # fennel = [(lp: with lp; [fennel])];
      # other = [ (lp: with lp; [ tomlua ]) ];
    };

    # dependencies available at RUN TIME for plugins.
    # Will be available to PATH within neovim terminal including LSPs
    lspsAndRuntimeDeps = with pkgs; {
      runtime = [
        nodePackages_latest.typescript
        universal-ctags
        stdenv.cc.cc
        fd
        fzf
        zoxide
        gnused
        gnugrep
        ripgrep
        jq
        gojq
        jqp
      ];

      lsp = [
        lua-language-server
        vscode-langservers-extracted
        nodePackages_latest.typescript-language-server
        nodePackages_latest.yaml-language-server
        nodePackages_latest.bash-language-server
        nodePackages_latest.dockerfile-language-server-nodejs

        # sql-language-server
        (pkgs.fetchFromGitHub {
          owner = "joe-re";
          repo = "sql-language-server";
          rev = "release";
          sha256 = "A73coX1zS5PPXGwEgbLcBsg3lvJD1IXiEiyKX68620w=";
        })

        nixd
        docker-ls
        lemminx
        pyright
        ruff
      ];

      tools = [
        nodePackages_latest.prettier
        nodePackages_latest.eslint # instead of `tsserver` for better linting

        stylua
        lua5_1
        luarocks
        selene

        nix-doc
        nixfmt-classic
        shellcheck
        shellharden
        shfmt

        nodePackages_latest.sql-formatter
        treefmt
        rustfmt
        markdownlint-cli
        terraform
      ];
    };

    startupPlugins = with pkgs.vimPlugins; {
      # theme = builtins.getAttr (extra.colorscheme or "kanagawa-nvim") {
      #   "onedark" = onedark-nvim;
      #   "catppuccin" = catppuccin-nvim;
      #   "catppuccin-mocha" = catppuccin-nvim;
      #   "kanagawa-nvim" = kanagawa-nvim;
      # };
      startup = with pkgs.vimPlugins; {
        colorscheme = [
          catppuccin-nvim
          kanagawa-nvim
        ];
        general = [
          dressing-nvim
          mini-nvim
          nui-nvim
          nvim-nio
          nvim-web-devicons
          oil-nvim
          lze
          lzextras
          snacks-nvim
          plenary-nvim
          vim-repeat
        ];
        lsp = [SchemaStore-nvim];
        mass_find_and_replace = {
          spectre = [nvim-spectre];
        };
      };
    };

    optionalPlugins = with pkgs.vimPlugins; {
      dev = {
        SQL = [
          vim-dadbod
          vim-dadbod-ui
          vim-dadbod-completion
        ];
        C = [
          vim-cmake
          clangd_extensions-nvim
        ];
        python = [
          nvim-dap-python
        ];
        go = [
          nvim-dap-go
        ];
        java = [
          nvim-jdtls
        ];
        markdown = [
          render-markdown-nvim
          markdown-preview-nvim
        ];
      };
      ai = {
        avante = [
          avante-nvim
        ];
        companion = [
          pkgs.neovimPlugins.codecompanion
        ];
        minuet = [
          minuet-ai-nvim
        ];
      };
      debug = [
        nvim-dap
        nvim-dap-ui
        nvim-dap-virtual-text
      ];
      #TODO: compare cmp vs blink for completions
      blink = with pkgs.vimPlugins; [
        luasnip
        cmp-cmdline
        blink-cmp
        blink-compat
        colorful-menu-nvim
      ];
      cmp = with pkgs.vimPlugins; [
        nvim-cmp
        luasnip
        friendly-snippets
        cmp_luasnip
        cmp-buffer
        cmp-path
        cmp-nvim-lua
        cmp-nvim-lsp
        cmp-cmdline
        cmp-nvim-lsp-signature-help
        cmp-cmdline-history
        lspkind-nvim
      ];

      treesitter = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects
        nvim-ts-autotag
        nvim-ts-context-commentstring
        nvim-autopairs
        rainbow-delimiters-nvim
        ts-comments-nvim
        vim-illuminate
        vim-matchup
      ];

      telescope = with pkgs.vimPlugins; [
        telescope-nvim
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        telescope-undo-nvim
        pkgs.neovimPlugins.telescope-egrepify
      ];

      lsp = with pkgs.vimPlugins; [
        nvim-lspconfig
        fidget-nvim
        lspsaga-nvim
        tiny-inline-diagnostic-nvim
        nvim-jdtls
        tsc-nvim
      ];

      navigation = with pkgs.vimPlugins; [
        flash-nvim
        tmux-nvim
        hop-nvim
        leap-nvim
        pkgs.neovimPlugins.nap
      ];

      git = with pkgs.vimPlugins; [
        git-conflict-nvim
        diffview-nvim
        lazygit-nvim
        gitsigns-nvim
      ];

      explorer = with pkgs.vimPlugins; [
        nvim-tree-lua
        pkgs.neovimPlugins.nvim-tree-preview
        yazi-nvim
      ];

      filetypes = with pkgs.vimPlugins; [
        csvview-nvim
        mkdnflow-nvim
        pkgs.neovimPlugins.log-highlight
        kulala-nvim
      ];

      persistence = with pkgs.vimPlugins; [
        persisted-nvim
        auto-save-nvim
        undotree
      ];

      test = with pkgs.vimPlugins; [
        neotest
        neotest-jest
        neotest-vitest
        neotest-playwright
        FixCursorHold-nvim
      ];

      ui = with pkgs.vimPlugins; [
        bufferline-nvim
        comment-box-nvim
        helpview-nvim
        nvim-notify
        pkgs.neovimPlugins.hlargs
        lualine-nvim
        noice-nvim
        neoscroll-nvim
        nvim-bqf
        nvim-scrollbar
        nvim-scrollview
        nvim-hlslens
        nvim-ufo
        marks-nvim
        registers-nvim
        todo-comments-nvim
        nvim-highlight-colors
        ccc-nvim
        pkgs.neovimPlugins.incline
        pkgs.neovimPlugins.reticle
        trouble-nvim
        dropbar-nvim
      ];

      lib = with pkgs.vimPlugins; [
        # legendary-nvim
        sqlite-lua

        # avante-nvim
        render-markdown-nvim
      ];

      utils = with pkgs.vimPlugins; [
        legendary-nvim
        nvim-surround
        toggleterm-nvim
        conform-nvim
        grug-far-nvim
        hydra-nvim
        live-command-nvim
        scope-nvim
        sniprun
        snacks-nvim
        dial-nvim
        mini-nvim
        vim-visual-multi
        gx-nvim
        pkgs.neovimPlugins.vim-caser
        pkgs.neovimPlugins.nvim-recorder
        debugprint-nvim
        pkgs.neovimPlugins.cutlass
        pkgs.neovimPlugins.stay-in-place
        pkgs.neovimPlugins.code_runner
        pkgs.neovimPlugins.jq-playground
      ];

      other = [
        nvim-highlight-colors
        which-key-nvim
        eyeliner-nvim
        todo-comments-nvim
        vim-startuptime
      ];
    };
  }
