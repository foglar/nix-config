{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./programming/code.nix
    ./programming/git.nix
    ./programming/neovim.nix

    ../apps/hacking.nix
    ../apps/games.nix
    ../apps/applications.nix
    ../apps/terminal_tools.nix
    ../apps/programming.nix

    ./applications/firefox.nix
    ./applications/spotify.nix

    ./tools/oh-my-posh.nix
    ./tools/shell.nix
    ./tools/kitty.nix
    ./tools/tmux.nix
    ./tools/zoxide.nix
  ];

  sh.bash = {
    enable = lib.mkDefault true;
    oh-my-posh.enable = lib.mkDefault true;
  };

  program = {
    kitty.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;

    firefox.enable = lib.mkDefault true;
    spotify.enable = lib.mkDefault true;

    vscode = {
      enable = lib.mkDefault true;
      ide = {
        python.enable = lib.mkDefault true;
        go.enable = lib.mkDefault true;
        csharp.enable = lib.mkDefault true;
        cpp.enable = lib.mkDefault false;
        web.enable = lib.mkDefault true;
      };
      nix.enable = lib.mkDefault true;
      markdown.enable = lib.mkDefault true;
      ai.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      
      themes.enable = lib.mkDefault false;
    };
    git.enable = lib.mkDefault true;
    neovim.enable = lib.mkDefault true;
  };

  app_list = {
    terminal_tools.enable = lib.mkDefault true;
    programming.enable = lib.mkDefault true;
    games.enable = lib.mkDefault false;
    applications.enable = lib.mkDefault true;
    hacking.enable = lib.mkDefault true;
  };

  programs = {
    bat.enable = lib.mkDefault true;
    btop.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
  };

  stylix.targets = {
    bat.enable = lib.mkDefault true;
    btop.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    neovim.enable = lib.mkDefault true;
  };

  home.packages = with pkgs; [
    alejandra
    nh
    nixd
  ];
}
