{
  pkgs,
  lib,
  config,
  userSettings,
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
    enable =
      if userSettings.shell == "bash"
      then lib.mkDefault true
      else lib.mkDefault false;
    oh-my-posh.enable =
      if userSettings.shell == "bash"
      then lib.mkDefault true
      else lib.mkDefault false;
  };

  sh.zsh = {
    enable =
      if userSettings.shell == "zsh"
      then lib.mkDefault true
      else lib.mkDefault false;
    oh-my-posh.enable =
      if userSettings.shell == "zsh"
      then lib.mkDefault true
      else lib.mkDefault false;
  };

  sh.oh-my-posh.enable = lib.mkDefault true;

  program = {
    kitty.enable =
      if userSettings.terminal == "kitty"
      then lib.mkDefault true
      else lib.mkDefault false;
    tmux.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;

    firefox.enable =
      if userSettings.browser == "firefox"
      then lib.mkDefault true
      else lib.mkDefault false;
    spotify.enable = lib.mkDefault true;

    vscode = {
      enable = lib.mkDefault true;
      ide = {
        python.enable = lib.mkDefault false;
        go.enable = lib.mkDefault false;
        csharp.enable = lib.mkDefault false;
        cpp.enable = lib.mkDefault false;
        web.enable = lib.mkDefault false;
      };
      nix.enable = lib.mkDefault false;
      markdown.enable = lib.mkDefault false;
      ai.enable = lib.mkDefault false;
      git.enable = lib.mkDefault false;

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
  };

  home.packages = with pkgs; [
    alejandra
    nh
    nixd
  ];

  home.file = {
    ".prettierrc".text = ''
      {
        "tabWidth": 4,
        "useTabs": true
      }
    '';
  };
}
