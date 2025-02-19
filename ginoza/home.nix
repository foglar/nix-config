{
  pkgs,
  pkgs-stable,
  userSettings,
  ...
}: {
  # Home manager configuration
  home.username = "${userSettings.username}";
  home.homeDirectory = "/home/${userSettings.username}";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  imports = [
    ../nixos/home/packages/packages.nix
    ../nixos/home/desktop/gnome/gnome.nix
  ];

  # Desktop management
  desktop.gnome.enable = true;

  # Shell management
  sh.oh-my-posh.enable = false;
  sh.bash = {
    enable = true;
    oh-my-posh.enable = false;
  };

  sh.zsh = {
    enable = false;
    oh-my-posh.enable = false;
  };

  # Application lists
  app_list = {
    hacking.enable = false;
    applications.enable = false;
    terminal_tools.enable = false;
    programming.enable = false;
  };

  # Configured programs to enable
  program = {
    kitty.enable = false;
    tmux.enable = false;
    zoxide.enable = false;
    ranger.enable = false;
    vscode.enable = false;
    git.enable = false;
    neovim.enable = false;
    firefox.enable = true;
    qutebrowser.enable = false;
    spotify.enable = false;
  };

  # Basic programs to enable
  programs = {
    bat.enable = false;
    btop.enable = false;
    fzf.enable = false;
  };

  # User defined packages
  home.packages =
    (with pkgs-stable; [
      libreoffice
      inkscape
      gimp
      mpv
      loupe
    ])
    ++ (
      with pkgs; [harmony-music]
    );

  programs.home-manager.enable = true;
}
