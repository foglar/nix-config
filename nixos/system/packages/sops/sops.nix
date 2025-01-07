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

        templates = {
          "${userSettings.hostname}/syncthing".content = ''${config.sops.placeholder."${userSettings.hostname}/syncthing"}'';
        };
      };
    };

    # Password hash
    users.users.${userSettings.username}.hashedPasswordFile = "${config.sops.secrets."${userSettings.hostname}/password-hash".path}";

    # YubiKey IDs
    security.pam.yubico.id = [17032113];
    #++ (
    #  if config.program.yubikey.enable
    #  then ["${config.sops.secrets.yubikey_id}".value]
    #  else []
    #);

    # Syncthing password
    #services.syncthing.settings.gui.password = config.sops.templates."${userSettings.hostname}/syncthing".content;
  };
}
