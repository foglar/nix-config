{
  lib,
  config,
  userSettings,
  ...
}: {
  options = {
    program.docker.enable = lib.mkEnableOption "Enable Docker";
  };

  config = lib.mkIf config.program.docker.enable {
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    users.users.${userSettings.username}.extraGroups = [ "docker" ];
  };
}
