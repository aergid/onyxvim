{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    # see :help nixCats.flake.inputs
    # If you want your plugin to be loaded by the standard overlay,
    # i.e. if it wasnt on nixpkgs, but doesn't have an extra build step.
    # Then you should name it "plugins-something"

    # If you wish to define a custom build step not handled by nixpkgs,
    # then you should name it in a different format, and deal with that in the
    # overlay defined for custom builds in the overlays directory.
    # for specific tags, branches and commits, see:
    # https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake.html#examples

    # neovim-nightly-overlay = {
    #   url = "github:nix-community/neovim-nightly-overlay";
    # };

    # NOTE: If input as plugins-hlargs, add it with `pkgs.neovimPlugins.hlargs` (Do not add `-nvim`)
    "plugins-hlargs" = {
      url = "github:m-demare/hlargs.nvim";
      flake = false;
    };

    "plugins-nvim-tree-preview" = {
      url = "github:b0o/nvim-tree-preview.lua";
      flake = false;
    };

    "plugins-vim-caser" = {
      url = "github:arthurxavierx/vim-caser";
      flake = false;
    };

    "plugins-log-highlight" = {
      url = "github:fei6409/log-highlight.nvim";
      flake = false;
    };

    "plugins-reticle" = {
      url = "github:tummetott/reticle.nvim";
      flake = false;
    };

    "plugins-telescope-egrepify" = {
      url = "github:fdschmidt93/telescope-egrepify.nvim";
      flake = false;
    };

    "plugins-nap" = {
      url = "github:liangxianzhe/nap.nvim";
      flake = false;
    };

    "plugins-incline" = {
      url = "github:b0o/incline.nvim";
      flake = false;
    };

    "plugins-code_runner" = {
      url = "github:CRAG666/code_runner.nvim";
      flake = false;
    };

    "plugins-nvim-recorder" = {
      url = "github:chrisgrieser/nvim-recorder";
      flake = false;
    };

    "plugins-cutlass" = {
      url = "github:gbprod/cutlass.nvim";
      flake = false;
    };

    "plugins-stay-in-place" = {
      url = "github:gbprod/stay-in-place.nvim";
      flake = false;
    };

    # NOTE: codecompanion-nvim is available but I need latest
    "plugins-codecompanion" = {
      url = "github:olimorris/codecompanion.nvim";
      flake = false;
    };

    "plugins-jq-playground" = {
      url = "github:yochem/jq-playground.nvim";
      flake = false;
    };
  };

  # see :help nixCats.flake.outputs
  outputs = { self, nixpkgs, nixCats, ... }@inputs:
    let
      inherit (inputs.nixCats) utils;
      luaPath = "${./.}";
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      # the following extra_pkg_config contains any values
      # which you want to pass to the config set of nixpkgs
      # import nixpkgs { config = extra_pkg_config; inherit system; }
      # will not apply to module imports
      # as that will have your system values
      extra_pkg_config = {
        allowUnfree = true;
        doCheck =
          false; # <- seriously, python stuff runs 10 years of tests its not worth it.
      };
      # System variables get resolved within the builder itself,
      # and then passed to your # categoryDefinitions and packageDefinitions
      # This allows you to use `${pkgs.system}`

      # sometimes our overlays require a ${system} to access the overlay.
      # Your dependencyOverlays can either be lists
      # in a set of ${system}, or simply a list.
      # the nixCats builder function will accept either.
      # see :help nixCats.flake.outputs.overlays
      dependencyOverlays =
        # (import ./overlays inputs) ++
        [
          # This overlay grabs all the inputs named in the format
          # `plugins-<pluginName>`
          # Once we add this overlay to our nixpkgs, we are able to
          # use `pkgs.neovimPlugins`, which is a set of our plugins.
          (utils.standardPluginOverlay inputs)
          # add any other flake overlays here.

          # when other people mess up their overlays by wrapping them with system,
          # you may instead call this function on their overlay.
          # it will check if it has the system in the set, and if so return the desired overlay
          # (utils.fixSystemizedOverlay inputs.codeium.overlays
          #   (system: inputs.codeium.overlays.${system}.default)
          # )
        ];

      # :help nixCats.flake.outputs.categories
      # :help nixCats.flake.outputs.categoryDefinitions.scheme
      categoryDefinitions = import ./categories.nix inputs;

      # packageDefinitions:

      # Now build a package with specific categories from above
      # All categories you wish to include must be marked true,
      # but false may be omitted.
      # This entire set is also passed to nixCats for querying within the lua.
      # It is directly translated to a Lua table, and a get function is defined.
      # The get function is to prevent errors when querying subcategories.

      # see :help nixCats.flake.outputs.packageDefinitions
      packageDefinitions = {
        # NOTE: the name needs to be the same as `defaultPackageName`
        nvim = { pkgs, ... }@misc: {
          categories = {
            runtime = true;
            lsp = true;
            tools = true;
            startup = true;
            optional = true;
            dev = true;
            ai = true;
            debug = true;
            # blink = false;
            cmp = true;
            treesitter = true;
            telescope = true;
            navigation = true;
            git = true;
            explorer = true;
            filetypes = true;
            persistence = true;
            ui = true;
            lib = true;
            utils = true;
            other = true;
            test = true;
          };
          # NOTE: see :help nixCats.flake.outputs.packageDefinitions
          settings = {
            # package name and default launch name is `nixCats`,
            # or, whatever you named the package definition in the packageDefinitions set.
            aliases = [ "vi" "vim" ];

            # explained below in the `regularCats` package's definition
            # OR see :help nixCats.flake.outputs.settings for all of the settings available
            wrapRc = true;
            configDirName = "onyxnvim";
            # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
          };
          # enable the categories from categoryDefinitions
          extra = {
            # to keep the categories table from being filled with non category things that you want to pass
            # there is also an extra table you can use to pass extra stuff.
            # but you can pass all the same stuff in any of these sets and access it in lua
            nixdExtras = { nixpkgs = nixpkgs; };
          };
        };

        regularCats = { pkgs, ... }@misc: {
          categories = {
            runtime = true;
            lsp = true;
            tools = true;
            startup = true;
            optional = true;
            dev = true;
            ai = true;
            debug = true;
            blink = false;
            cmp = true;
            treesitter = true;
            telescope = true;
            navigation = true;
            git = true;
            explorer = true;
            filetypes = true;
            persistence = true;
            ui = true;
            lib = true;
            utils = true;
            other = true;
            test = true;
          };
          settings = {
            # IMPURE PACKAGE: normal config reload
            # include same categories as main config,
            # will load from vim.fn.stdpath('config')
            wrapRc = false;
            # or tell it some other place to load
            # unwrappedCfgPath = "/some/path/to/your/config";

            # configDirName: will now look for nixCats-nvim within .config and .local and others
            # this can be changed so that you can choose which ones share data folders for auths
            # :h $NVIM_APPNAME
            configDirName = "onyxnvim";

            aliases = [ ];

            # If you wanted nightly, uncomment this, and the flake input.
            # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
          };
          extra = { nixdExtras = { nixpkgs = nixpkgs; }; };
        };
      };

      defaultPackageName = "nvim";
      # defaultPackageName is also passed to utils.mkNixosModules and utils.mkHomeModules
      # and it controls the name of the top level option set.
      # If you made a package named `nvim` your default package as we did here,
      # the modules generated would be set at:
      # config.nvim = {
      #   enable = true;
      #   packageNames = [ "nvim" ]; # <- the packages you want installed
      #   <see :h nixCats.module for options>
      # }
      # In addition, every package exports its own module via passthru, and is overrideable.
      # so you can yourpackage.homeModule and then the namespace would be that packages name.
      # you shouldnt need to change much past here, but you can if you wish.
      # but you should at least eventually try to figure out whats going on here!
      # see :help nixCats.flake.outputs.exports
    in forEachSystem (system:
      let
        # and this will be our builder! it takes a name from our packageDefinitions as an argument, and builds an nvim.
        nixCatsBuilder = utils.baseBuilder luaPath {
          # we pass in the things to make a pkgs variable to build nvim with later
          inherit nixpkgs system dependencyOverlays extra_pkg_config;
          # and also our categoryDefinitions and packageDefinitions
        } categoryDefinitions packageDefinitions;
        # call it with our defaultPackageName
        defaultPackage = nixCatsBuilder defaultPackageName;

        # this pkgs variable is just for using utils such as pkgs.mkShell
        # within this outputs set.
        pkgs = import nixpkgs { inherit system; };
        # The one used to build neovim is resolved inside the builder
        # and is passed to our categoryDefinitions and packageDefinitions
      in {
        # these outputs will be wrapped with ${system} by utils.eachSystem

        # this will generate a set of all the packages
        # in the packageDefinitions defined above
        # from the package we give it.
        # and additionally output the original as default.
        packages = utils.mkAllWithDefault defaultPackage;

        # choose your package for devShell
        # and add whatever else you want in it.
        devShells = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = [ defaultPackage ];
            inputsFrom = [ ];
            shellHook = "";
          };
        };
      }) // (let
        # we also export a nixos module to allow reconfiguration from configuration.nix
        nixosModule = utils.mkNixosModules {
          inherit defaultPackageName dependencyOverlays luaPath
            categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
        };
        # and the same for home manager
        homeModule = utils.mkHomeModules {
          inherit defaultPackageName dependencyOverlays luaPath
            categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
        };
      in {
        # these outputs will be NOT wrapped with ${system}

        # this will make an overlay out of each of the packageDefinitions defined above
        # and set the default overlay to the one named here.
        overlays = utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
        } categoryDefinitions packageDefinitions defaultPackageName;

        nixosModules.default = nixosModule;
        homeModules.default = homeModule;

        inherit utils nixosModule homeModule;
        inherit (utils) templates;
      });
}
