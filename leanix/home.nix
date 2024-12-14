{lib, ...}: {
  home.username = "konsta";
  home.homeDirectory = "/home/konsta";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  imports = [
    ../nixos/packages/packages.nix
  ];

  program.firefox.enable = lib.mkDefault true;

  group.terminal_tools.enable = true;

  program = {
    kitty.enable = lib.mkDefault false;
    tmux.enable = lib.mkDefault false;
    zoxide.enable = lib.mkDefault false;
  };

  sh.bash = {
    enable = lib.mkDefault true;
    oh-my-posh.enable = lib.mkDefault false;
  };

  programs.home-manager.enable = true;
}
