{
  lib,
  config,
  ...
}: {
  options = {ui.lualine.enable = lib.mkEnableOption "Enable lualine module";};

  config = lib.mkIf config.ui.lualine.enable {
    plugins.lualine = {
      enable = true;
      settings = {
        alwaysDivideMiddle = true;
        globalstatus = true;
        ignoreFocus = ["neo-tree"];
        extensions = ["fzf"];
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
          lualine_a = ["mode"];
          lualine_b = ["branch" "" "diff" "diagnostics"];
          lualine_c = ["filetype"];
          lualine_y = ["progress"];
        };
      };
    };
  };
}
