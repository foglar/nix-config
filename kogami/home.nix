{
  userSettings,
  ...
}: {
  # Home manager configuration
  home.username = "${userSettings.username}";
  home.homeDirectory = "/home/${userSettings.username}";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ../nixos/home/packages/packages.nix
    ../nixos/home/desktop/desktops.nix
  ];

  # Shell management
  sh.oh-my-posh.enable = true;

  sh.bash = {
    enable = true;
    oh-my-posh.enable = true;
  };

  sh.zsh = {
    enable = true;
    oh-my-posh.enable = true;
  };

  # Application lists
  app_list = {
    applications.enable = true;
    games.enable = true;
    hacking.enable = true;
    programming.enable = true;
    terminal_tools.enable = true;
  };

  # Configured programs to enable
  program = {
    kitty.enable = true;
    tmux.enable = true;
    zoxide.enable = true;

    vscode = {
      enable = true;
      ide = {
        python.enable = true;
        go.enable = true;
        csharp.enable = true;
        cpp.enable = false;
        web.enable = true;
      };
      nix.enable = true;
      markdown.enable = true;
      ai.enable = true;
      git.enable = true;

      themes.enable = false;
    };

    git.enable = true;
    neovim.enable = true;

    firefox.enable = true;
    spotify.enable = true;
  };

  # Basic programs to enable
  programs = {
    bat.enable = true;
    btop.enable = true;
    fzf.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
