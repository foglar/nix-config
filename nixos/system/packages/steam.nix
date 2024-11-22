{
  lib,
  config,
  ...
}: {
  options = {
    package.steam.enable = lib.mkEnableOption "Enable Steam module";
  };

  config = lib.mkIf config.package.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };
}
