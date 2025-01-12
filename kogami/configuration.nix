{
  inputs,
  pkgs,
  pkgs-stable,
  userSettings,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../nixos/system/packages.nix
    ../nixos/system/system.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Home manager
  home-manager = {
    extraSpecialArgs = {inherit inputs pkgs pkgs-stable userSettings;};
    backupFileExtension = "backup";
    users = {
      ${userSettings.username} = import ./home.nix;
    };
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      inputs.plasma-manager.homeManagerModules.plasma-manager
    ];
  };

  boot.loader.systemd-boot.enable = true;
  sys = {
    audio.enable = true;
    #bootloader.systemd-boot.enable = true;
    desktop = {
      steamdeck.enable = true;
    };
    fonts.packages = true;
    locales.enable = true;
    network.enable = true;
    bluetooth = {
      enable = true;
      blueman.enable = true;
    };
    nvidia = {
      enable = true;
      mode = "offload";
    };
    printing.enable = true;
    login = {
      sddm.enable = true;
      gdm.enable = false;
    };
    style.enable = true;
  };

  # Configured programs to enable
  program = {
    docker.enable = false;
    podman.enable = true;
    steam.enable = true;
    proxychains.enable = true;
    tor.enable = true;
    virt-manager.enable = true;
    virtualbox.enable = false;
    yubikey = {
      enable = true;
      lock-on-remove = false;
      notify = true;
    };
    ssh.client.enable = true;
  };

  # Basic programs to enable
  programs = {
    kdeconnect.enable = true;
    wireshark.enable = true;
    auto-cpufreq.enable = true;
    nix-ld.dev.enable = true;
  };

  environment.systemPackages = [
    inputs.install-script.packages.x86_64-linux.default
    inputs.shinya-nvf.packages.x86_64-linux.nvf
  ];

  #services.twingate.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
