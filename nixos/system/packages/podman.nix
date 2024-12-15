{
  lib,
  config,
  username,
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

    users.users.${username} = {
      isNormalUser = true;
      extraGroups = ["podman"];
    };
  };
}
