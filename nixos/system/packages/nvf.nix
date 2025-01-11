{...}: {
  vim = {
    viAlias = true;
    vimAlias = true;

    theme = {
      enable = true;
      name = "catppuccin"; # catppuccin, tokyo-night, one-dark
      style = "mocha";
    };

    languages = {
      enableLSP = true;
      enableTreesitter = true;

      nix.enable = true;
      rust.enable = true;
      python.enable = true;
      lua.enable = true;
      csharp.enable = true;
      go.enable = true;
      markdown.enable = true;
      clang.enable = true;
      html.enable = true;
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
  };
}
