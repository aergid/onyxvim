{ lib, config, ... }:
{
  options = {
    ui.lualine.enable = lib.mkEnableOption "Enable lualine module";
  };

  config = lib.mkIf config.ui.lualine.enable {
    plugins.lualine = {
      enable = true;
      settings = {
        alwaysDivideMiddle = true;
        globalstatus = true;
        ignoreFocus = [ "neo-tree" ];
        extensions = [ "fzf" ];
        theme = "auto";
        componentSeparators = {
          left = "|";
          right = "|";
        };
        sectionSeparators = {
          left = "█"; # 
          right = "█"; # 
        };
			# +-------------------------------------------------+
			# | A | B | C                             X | Y | Z |
			# +-------------------------------------------------+
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [
            "branch"
            ""
            "diff"
            "diagnostics"
          ];
          lualine_c = [
            ""
            {
              name.__raw = ''
                require('nvim-navic').get_location
              '';
              extraConfig = {
                cond.__raw = ''
                  require('nvim-navic').is_available
                '';
              };
            }
          ];
          lualine_x = [ "filetype" ];
          lualine_y = [ "progress" ];
        };
      };
    };

  };
}

