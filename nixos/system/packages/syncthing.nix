{
  lib,
  config,
  userSettings,
  ...
}: {
  options = {
    program.syncthing.enable = lib.mkEnableOption "syncthing";
  };

  config = lib.mkIf config.program.syncthing.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      settings.gui = {
        user = "${userSettings.username}";
        #! password = "test";
        #! User Hashed password is stored in SOPS
        #! and is set in the module configuration
        #! file ./sops/sops.nix
      };

      settings = {
        devices = {
          "Masaoka" = {id = "LGQUK6E-YEPVYKC-5MNXXHO-FZRD6SE-BBPHNGE-RKRGSSW-WIIWNVA-ZO3DKQO";};
          "Tsunemori" = {id = "JPOXL54-KPM6LBK-52B6NDP-3PC76WS-VNMSQLK-2S4HWDZ-6ORFJ55-7KDO3QG";};
        };
        #folders = {
        #  "Documents" = {
        #    path = "/home/${userSettings.username}/Documents";
        #    devices = ["Masaoka"];
        #  };
        #};
      };
    };

    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
  };
}
