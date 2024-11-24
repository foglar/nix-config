{lib, ...}: {
  imports = [
    ./packages/docker.nix
    ./packages/steam.nix
    ./packages/tor.nix
    ./packages/virtual-machines.nix
  ];

  package = {
    docker.enable = lib.mkDefault true;
    steam.enable = lib.mkDefault true;
    proxychains.enable = lib.mkDefault true;
    tor.enable = lib.mkDefault true;
    virt-manager.enable = lib.mkDefault true;
  };
  desktop.steamdeck.enable = lib.mkDefault false;
  programs.kdeconnect.enable = true;
  programs.wireshark.enable = true;
}
