{
  plugins.nvim-ufo = {
    enable = true;
    settings = {
      provider_selector.__raw = ''
        function(bufnr, filetype, buftype)
          return {'treesitter', 'indent'}
        end
      '';
    };
  };
}
