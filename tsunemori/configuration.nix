{pkgs, ...}: {
  #imports = [
  #  ../nixos/system/packages.nix
  #  ../nixos/system/system.nix
  #];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  home-manager = {
    config = ./home.nix;
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
  };

  #sys = {
  #  audio.enable = false;
  #  bootloader.systemd-boot.enable = false;
  #  desktop = {
  #    steamdeck.enable = false;
  #  };
  #  fonts.packages = false;
  #  locales.enable = true;
  #  network.enable = false;
  #  bluetooth = {
  #    enable = false;
  #    blueman.enable = false;
  #  };
  #  nvidia = {
  #    enable = false;
  #    mode = "none";
  #  };
  #  printing.enable = false;
  #  login = {
  #    sddm.enable = false;
  #    gdm.enable = false;
  #  };
  #  style.enable = false;
  #};
#
  #program = {
  #  docker.enable = true;
  #  podman.enable = false;
  #  steam.enable = false;
  #  proxychains.enable = false;
  #  tor.enable = false;
  #  virt-manager.enable = false;
  #  virtualbox.enable = false;
  #  yubikey = {
  #    enable = false;
  #    lock-on-remove = false;
  #    notify = false;
  #  };
  #  ssh.client.enable = false;
  #};

  #nixpkgs.config.allowUnfree = true;

  # Simply install just the packages
  environment.packages = with pkgs; [
    # User-facing stuff that you really really want to have
    vim # or some other editor, e.g. nano or neovim

    # Some common stuff that people expect to have
    #procps
    #killall
    #diffutils
    #findutils
    #utillinux
    #tzdata
    #hostname
    #man
    #gnugrep
    #gnupg
    #gnused
    #gnutar
    #bzip2
    #gzip
    #xz
    #zip
    #unzip
  ];

  environment.etcBackupExtension = ".bak";
  system.stateVersion = "24.05";
}
