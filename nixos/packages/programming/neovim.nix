{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    program.neovim.enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf config.program.neovim.enable {
    home.sessionVariables.EDITOR = "nvim";

    programs.neovim.enable = true;

    #programs.neovim = let
    #  toLua = str: "lua << EOF\n${str}\nEOF\n";
    #  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    #in {
    #  enable = true;
    #  defaultEditor = true;
    #  viAlias = true;
    #  vimAlias = true;
    #  extraPackages = with pkgs; [
    #    lua-language-server
    #    xclip
    #    wl-clipboard
    #  ];
#
    #  plugins = with pkgs.vimPlugins; [
    #    {
    #      plugin = nvim-lspconfig;
    #      config = toLuaFile ./nvim/plugin/lsp.lua;
    #    }
    #    #pkgs.vimPlugins.LazyVim
    #    #pkgs.vimPlugins.mason-lspconfig-nvim
    #    #pkgs.vimPlugins.nvchad
    #  ];
    #};
  };
}
