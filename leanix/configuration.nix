{
  inputs,
  lib,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../nixos/system/packages.nix
    ../nixos/system/system.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  inputs.home-manager = {
    extraSpecialArgs = {inherit inputs pkgs pkgs-stable;};
    backupFileExtension = "backup";
    users = {
      konsta = import ./home.nix;
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;

  environment.sessionVariables = {
    FLAKE = "/home/konsta/.dotfiles";

    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  };

  users.users.konsta = {
    isNormalUser = true;
    description = "konsta";
    extraGroups = ["wheel"];
  };


  sys = {
    audio.enable = true;
    desktop = {
      plasma.enable = false;
      gnome.enable = true;
      hyprland.enable = false;
    };
    fonts.packages = true;
    locales.enable = true;
    network.enable = true;
    bluetooth.enable = true;
    nvidia.enable = false;
    printing.enable = false;
    sddm.enable = false;
    style.enable = true;
  };

  package = {
    docker.enable = false;
    steam.enable = false;
    proxychains.enable = false;
    tor.enable = false;
    virt-manager.enable = false;
  };
  desktop.steamdeck.enable = false;
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
