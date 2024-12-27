{lib, ...}: {
  imports = [
    ./packages/docker.nix
    ./packages/podman.nix
    ./packages/steam.nix
    ./packages/tor.nix
    ./packages/virtual-machines.nix
    ./packages/yubikey.nix
    ./packages/sops/sops.nix
    ./packages/ssh-client.nix
  ];

  program = {
    docker.enable = lib.mkDefault false;
    podman.enable = lib.mkDefault true;
    steam.enable = lib.mkDefault true;
    proxychains.enable = lib.mkDefault true;
    tor.enable = lib.mkDefault true;
    virt-manager.enable = lib.mkDefault true;
    virtualbox.enable = lib.mkDefault true;
    yubikey = {
      enable = lib.mkDefault false;
      lock-on-remove = lib.mkDefault false;
      notify = lib.mkDefault false;
    };
    ssh.client.enable = lib.mkDefault true;
  };
  sys.desktop.steamdeck.enable = lib.mkDefault false;
  sys.security.sops.enable = lib.mkDefault true;
  programs.kdeconnect.enable = lib.mkDefault true;
  programs.wireshark.enable = lib.mkDefault true;
}
