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
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Home manager
  home-manager = {
    extraSpecialArgs = {inherit inputs pkgs pkgs-stable userSettings;};
    backupFileExtension = "backup";
    users = {
      ${userSettings.username} = import ./home.nix;
    };
  };

  # User configuration
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = "${userSettings.username}";
    extraGroups = ["wheel"];
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;

  # Environment variables
  environment.sessionVariables = {
    FLAKE = "/home/${userSettings.username}/.dotfiles";

    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  };

  # System level configuration
  sys = {
    audio.enable = true;
    desktop = {
      plasma.enable = false;
      gnome.enable = true;
      hyprland.enable = false;
      steamdeck.enable = false;
    };
    fonts.packages = true;
    locales.enable = true;
    network.enable = true;
    bluetooth = {
      enable = true;
      blueman.enable = false;
    };
    nvidia.enable = false;
    printing.enable = true;
    login = {
      sddm.enable = false;
      gdm.enable = true;
    };
    style.enable = true;
  };

  # Configured programs to enable
  program = {
    docker.enable = false;
    podman.enable = true;
    steam.enable = false;
    proxychains.enable = false;
    tor.enable = false;
    virt-manager.enable = false;
    virtualbox.enable = false;
  };

  # Basic programs to enable
  programs.kdeconnect.enable = true;
  programs.wireshark.enable = false;

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
  system.stateVersion = "24.11"; # Did you read the comment?
}
