{...}: {
  home.stateVersion = "24.05";

  imports = [
    ../nixos/home/packages/droid-packages.nix
  ];

  sh.bash = {
    enable = true;
    oh-my-posh.enable =
      true;
  };

  sh.zsh = {
    enable = true;
    oh-my-posh.enable = true;
  };

  sh.oh-my-posh.enable = true;

  program = {
    fastfetch.enable = true;
    tmux.enable = true;
    zoxide.enable = true;
    git.enable = true;
    neovim.enable = true;
  };

  app_list = {
    terminal_tools.enable = true;
  };

  programs = {
    bat.enable = true;
    btop.enable = true;
    fzf.enable = true;
  };

  programs.home-manager.enable = true;
}
