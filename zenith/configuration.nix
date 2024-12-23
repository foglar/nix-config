{
  inputs,
  pkgs,
  pkgs-stable,
  userSettings,
  config,
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
  programs.nix-ld.dev.enable = true;

  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/foglar/.config/sops/age/keys.txt";

  sops.secrets."zenith/password-hash" = {
    neededForUsers = true;
  };

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

  # User configuration
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = "${userSettings.username}";
    extraGroups = ["wheel"];
    hashedPasswordFile = "${config.sops.secrets."zenith/password-hash".path}";
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;

  # Environment variables
  environment.sessionVariables = {
    FLAKE = "/home/${userSettings.username}/dotfiles";
  };

  # System level configuration
  sys = {
    audio.enable = true;
    desktop = {
      plasma.enable = false;
      gnome.enable = false;
      hyprland.enable = true;
      steamdeck.enable = true;
    };
    fonts.packages = true;
    locales.enable = true;
    network.enable = true;
    bluetooth = {
      enable = true;
      blueman.enable = true;
    };
    nvidia.enable = true;
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
    yubikey.enable = true;
  };

  # Basic programs to enable
  programs.kdeconnect.enable = true;
  programs.wireshark.enable = true;

  services.twingate.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
