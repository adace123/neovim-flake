{pkgs, ...}: {
  config = {
    colorschemes = {
      catppuccin = {
        enable = true;
        flavour = "mocha";
        integrations = {
          cmp = true;
          treesitter = true;
          telescope.enabled = true;
          indent_blankline.enabled = true;
          barbar = true;
        };
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      gruvbox
      nord-nvim
      everforest
      kanagawa-nvim
    ];
  };
}
