{...}: {
  home.username = "tsunemori";
  home.homeDirectory = "/home/tsunemori";
  home.stateVersion = "24.05";

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
    applications.enable = false;
    games.enable = false;
    hacking.enable = false;
    programming.enable = false;
    terminal_tools.enable = true;
  };

  # Configured programs to enable
  program = {
    kitty.enable = false;
    tmux.enable = true;
    zoxide.enable = true;

    vscode = {
      enable = false;
      ide = {
        python.enable = false;
        go.enable = false;
        csharp.enable = false;
        cpp.enable = false;
        web.enable = false;
      };
      nix.enable = false;
      markdown.enable = false;
      ai.enable = false;
      git.enable = false;

      themes.enable = false;
    };

    git.enable = true;
    neovim.enable = true;

    firefox.enable = false;
    spotify.enable = false;
  };

  # Basic programs to enable
  programs = {
    bat.enable = true;
    btop.enable = true;
    fzf.enable = true;
  };

  programs.home-manager.enable = true;
}
