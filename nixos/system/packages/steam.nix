{
  lib,
  config,
  pkgs,
  userSettings,
  ...
}: {
  options = {
    program.steam.enable = lib.mkEnableOption "Enable Steam module";
    sys.desktop.steamdeck.enable = lib.mkEnableOption "Enable Steam desktop integration";
  };

  config = lib.mkMerge [
    (lib.mkIf config.program.steam.enable {
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
    })
    (lib.mkIf config.sys.desktop.steamdeck.enable {
      services.getty.autologinUser = "${userSettings.username}";
      environment = {
        systemPackages = [pkgs.mangohud];
        loginShellInit = ''
          [[ "$(tty)" = "/dev/tty1" ]] && gs
        '';
      };
    })
  ];
}
