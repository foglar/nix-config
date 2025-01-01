{
  pkgs,
  lib,
  userSettings,
  ...
}: {
  imports = [
    ./programming/git.nix
    ./programming/neovim.nix

    ../apps/terminal_tools.nix

    ./tools/oh-my-posh.nix
    ./tools/shell.nix
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
    tmux.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    neovim.enable = lib.mkDefault true;
  };

  app_list = {
    terminal_tools.enable = lib.mkDefault true;
  };

  programs = {
    bat.enable = lib.mkDefault true;
    btop.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
  };

  home.packages = with pkgs; [
    alejandra
    nh
    nixd
  ];
}
