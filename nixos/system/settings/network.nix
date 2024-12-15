{
  lib,
  config,
  userSettings,
  ...
}: {
  options = {
    sys.network.enable = lib.mkEnableOption "Enable networking";
    sys.bluetooth.enable = lib.mkEnableOption "Enable Bluetooth support";
    sys.bluetooth.blueman.enable = lib.mkEnableOption "Enable Blueman App";
  };

  config = lib.mkMerge [
    (lib.mkIf config.sys.network.enable {
      networking.hostName = "${userSettings.hostname}"; # Define your hostname.
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Enable networking
      networking.networkmanager.enable = true;
      users.users.${userSettings.username}.extraGroups = ["networkmanager"];
    })
    (
      lib.mkIf config.sys.bluetooth.enable {
        hardware.bluetooth.enable = true; # enables support for Bluetooth
        hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
      }
    )
    (
      lib.mkIf config.sys.bluetooth.blueman.enable {
        services.blueman.enable = true;
      }
    )
  ];
}
