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
    sops = {
      defaultSopsFile = ./secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      age.keyFile = "/home/${userSettings.username}/.config/sops/age/keys.txt";
      age.generateKey = true;

      # SSH private keys
      secrets = {
        "ssh_keys/masaoka_private" = {
          path = "/home/${userSettings.username}/.ssh/id_masaoka";
          owner = userSettings.username;
          group = "users";
        };

        "${userSettings.hostname}/password-hash" = {
          neededForUsers = true;
        };

        "${userSettings.hostname}/syncthing" = {
          owner = userSettings.username;
          group = "users";
        };

        "yubikey_id" = {
          owner = userSettings.username;
          group = "users";
        };
      };

      templates = {
        "syncthing-password".content = ''${config.sops.placeholder."${userSettings.hostname}/syncthing"}'';
        "yubikey-id".content = ''${config.sops.placeholder.yubikey_id}'';
      };
    };

    # Password hash
    users.users.${userSettings.username}.hashedPasswordFile = "${config.sops.secrets."${userSettings.hostname}/password-hash".path}";

    # YubiKey IDs
    security.pam.yubico.id =
      []
      ++ (
        if config.program.yubikey.enable
        then [config.sops.templates."yubikey-id".content]
        else []
      );

    # Syncthing password
    services.syncthing.settings.gui.password = config.sops.templates."syncthing-password".content;
  };
}
