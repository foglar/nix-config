{
  lib,
  config,
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
  };
}
