{
  lib,
  config,
  userSettings,
  ...
}: {
  options = {
    sys.security.sops.enable = lib.mkEnableOption "Enable SOPS";
  };

  config = lib.mkIf config.sys.security.sops.enable {
    sops.defaultSopsFile = ./secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.age.keyFile = "/home/${userSettings.username}/.config/sops/age/keys.txt";

    sops.secrets."zenith/password-hash" = {
      neededForUsers = true;
    };

    users.users.${userSettings.username}.hashedPasswordFile = "${config.sops.secrets."${userSettings.hostname}/password-hash".path}";
  };
}
