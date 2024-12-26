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
  };

  config = lib.mkIf config.program.yubikey.enable {
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
  };
}
