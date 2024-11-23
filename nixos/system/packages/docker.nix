{
  lib,
  config,
  username,
  ...
}: {
  options = {
    package.docker.enable = lib.mkEnableOption "Enable Docker";
  };

  config = lib.mkIf config.package.docker.enable {
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    users.users.${username}.extraGroups = [ "docker" ];
  };
}
