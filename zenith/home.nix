{userSettings, ...}: {
  # Home manager configuration
  home.username = "${userSettings.username}";
  home.homeDirectory = "/home/${userSettings.username}";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ../nixos/home/packages/packages.nix
    ../nixos/home/desktop/desktops.nix
  ];

  # Desktop management
  desktop.hyprland.enable = true;
  desktop.kde.enable = true;
  desktop.gnome.enable = false;

  # Shell management
  sh.bash = {
    enable = true;
    oh-my-posh.enable = true;
  };

  # Application lists
  app_list = {
    hacking.enable = true;
    applications.enable = true;
    terminal_tools.enable = true;
    programming.enable = true;
    games.enable = true;
  };

  # Configured programs to enable
  program = {
    kitty.enable = true;
    tmux.enable = true;
    zoxide.enable = true;
    vscode.enable = true;
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

  home.file = {
    ".config/hypr/hyprlock.conf".source = ../config/hyprlock.conf;
    ".config/hypr/mocha.conf".source = ../config/mocha.conf;
    ".config/hypr/hypridle.conf".source = ../config/hypridle.conf;
    #".config/dolphinrc".source = ../config/dolphinrc;
    ".prettierrc".text = ''
      {
        "tabWidth": 4,
        "useTabs": true
      }
    '';
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
