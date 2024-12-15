{
  lib,
  config,
  userSettings,
  ...
}: {
  options = {
    program.podman.enable = lib.mkEnableOption "Enable Podman";
  };

  config = lib.mkIf config.program.podman.enable {
    virtualisation.containers.enable = true;
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    users.users.${userSettings.username} = {
      isNormalUser = true;
      extraGroups = ["podman"];
    };
  };
}
