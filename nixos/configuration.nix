{
  inputs,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./system/nvidia.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs pkgs pkgs-stable;};
    backupFileExtension = "backup";
    users = {
      foglar = import ./home.nix;
    };
  };

  stylix = {
    enable = true;
    image = ./aurora_borealis.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    polarity = "dark";
    autoEnable = true;

    # Set the cursor theme.
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      sizes = {
        desktop = 8;
        applications = 10;
        popups = 10;
        terminal = 12;
      };

      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      };
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  networking.hostName = "laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Printing
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [gutenprint hplip splix];
  hardware.printers = {
    #ensurePrinters = [
    #  {
    #    name = "HP_psc_1200_series";
    #    location = "Home";
    #    deviceUri = "usb://HP/psc%201200%20series?serial=UA51SGB35WT0&interface=1";
    #    model = "HP_psc_1200_series.ppd";
    #    ppdOptions = {
    #      PageSize = "A4";
    #    };
    #  }
    #];
    #ensureDefaultPrinter = "HP_psc_1200_series";
  };

  # Scanning
  hardware.sane.enable = true;
  services.ipp-usb.enable = true;
  hardware.sane.extraBackends = [pkgs.hplipWithPlugin];

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    monaspace
  ];

  services.displayManager = {
    defaultSession = "hyprland";
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      package = pkgs.kdePackages.sddm;
      extraPackages = [pkgs.sddm-astronaut pkgs.kdePackages.qtvirtualkeyboard];
    };
  };
  #services.desktopManager.plasma6.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  #environment.gnome.excludePackages = with pkgs; [
  #  gnome-tour
  #  gnome-connections
  #  epiphany # web browser
  #  geary # email reader. Up to 24.05. Starting from 24.11 the package name is just geary.
  #  #evince # document viewer
  #  gnome-weather
  #  gnome-contacts
  #  gnome-maps
  #  gnome-logs
  #  gnome-music
  #  gnome-system-monitor
  #  gnome-text-editor
  #  yelp
  #  totem
  #  snapshot
  #  seahorse
  #];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    ark
    plasma-browser-integration
    konsole
    oxygen
    gwenview
    okular
    elisa
    kate
    krdp
    khelpcenter
  ];

  # qt = {
  #   enable = true;
  #   platformTheme = "gnome";
  #   style = "adwaita-dark";
  # };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  programs.proxychains = {
    enable = true;
    chain.type = "dynamic";
    proxies = {
      tor-proxy = {
        enable = true;
        type = "socks5";
        host = "127.0.0.1";
        port = 9050;
      };
    };
  };

  services.tor = {
    enable = true;
  };
  services.tor.client.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    EDITOR = "nvim";
    FLAKE = "/home/foglar/dotfiles";
  };

  services.xserver = {
    xkb.layout = "us,cz";
    xkb.options = "grp:win_space_toggle";
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.foglar = {
    isNormalUser = true;
    description = "foglar";
    extraGroups = ["networkmanager" "wheel" "lp" "scanner"];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  programs.kdeconnect.enable = true;
  programs.wireshark.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    sddm-chili-theme
    (sddm-astronaut.override {
      themeConfig = {
        ScreenWidth = 1920;
        ScreenHeight = 1080;
        PartialBlur = false;
      };
    })
  ];

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
