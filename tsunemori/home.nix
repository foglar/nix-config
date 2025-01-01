{lib, ...}: {
  home.username = lib.mkForce "tsunemori";
  home.homeDirectory = "/home/tsunemori";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
