{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    program.yubikey = {
      enable = lib.mkEnableOption "Enable YubiKey authentication";
    };
    program.yubikey = {
      lock-on-remove = lib.mkEnableOption "Lock the session when the YubiKey is removed";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.program.yubikey.enable {
      environment.systemPackages = with pkgs; [
        yubioath-flutter
        yubikey-manager
        pam_u2f
      ];

      # Only have to be connected to the notebook
      #security.pam.services = {
      #  login.u2fAuth = true;
      #  sudo.u2fAuth = true;
      #};

      security.pam.yubico = {
        enable = true;
        debug = false;
        mode = "challenge-response";
        control = "sufficient";
        #! id = [ "1234567890" ];
        #! YubiKey ID is stored in SOPS
        #! and is set in the module configuration
        #! file ./sops/sops.nix
      };

      services.pcscd = {
        enable = true;
      };

      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    })
    (lib.mkIf config.program.yubikey.lock-on-remove {
      services.udev.extraRules = ''
        ACTION=="remove",\
         ENV{ID_BUS}=="usb",\
         ENV{ID_MODEL_ID}=="0407",\
         ENV{ID_VENDOR_ID}=="1050",\
         ENV{ID_VENDOR}=="Yubico",\
         RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
      '';
    })
  ];
}
