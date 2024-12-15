{lib, ...}: {
  imports = [
    ./packages/docker.nix
    ./packages/podman.nix
    ./packages/steam.nix
    ./packages/tor.nix
    ./packages/virtual-machines.nix
  ];

  program = {
    docker.enable = lib.mkDefault false;
    podman.enable = lib.mkDefault true;
    steam.enable = lib.mkDefault true;
    proxychains.enable = lib.mkDefault true;
    tor.enable = lib.mkDefault true;
    virt-manager.enable = lib.mkDefault true;
  };
  sys.desktop.steamdeck.enable = lib.mkDefault false;
  programs.kdeconnect.enable = lib.mkDefault true;
  programs.wireshark.enable = lib.mkDefault true;
}
