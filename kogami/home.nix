{userSettings, ...}: {
  # Home manager configuration
  home.username = "${userSettings.username}";
  home.homeDirectory = "/home/${userSettings.username}";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ../nixos/home/packages/packages.nix
    ../nixos/home/desktop/desktops.nix
  ];

  # Shell management
  sh = {
    oh-my-posh.enable = true;

    bash = {
      enable = true;
      oh-my-posh.enable = true;
    };

    zsh = {
      enable = true;
      oh-my-posh.enable = true;
    };
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
    ranger.enable = true;

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
    neovim.enable = false;

    firefox.enable = false;
    qutebrowser.enable = true;
    spotify.enable = true;
    vencord.enable = true;
  };

  # Basic programs to enable
  programs = {
    bat.enable = true;
    btop.enable = true;
    fzf.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
