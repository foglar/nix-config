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

    sops.secrets."${userSettings.hostname}/password-hash" = {
      neededForUsers = true;
    };

    # SSH private keys
    sops.secrets = {
      "ssh_keys/masaoka" = {
        path = "/home/${userSettings.username}/.ssh/id_masaoka";
        owner = userSettings.username;
        group = "users";
      };
    };

    users.users.${userSettings.username}.hashedPasswordFile = "${config.sops.secrets."${userSettings.hostname}/password-hash".path}";
    security.pam.yubico.id =
      []
      ++ (
        if config.program.yubikey.enable
        then ["${config.sops.secrets.yubikey_id}".value]
        else []
      );
  };
}
