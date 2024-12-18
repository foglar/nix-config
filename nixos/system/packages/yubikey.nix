{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    program.yubikey = {
      enable = lib.mkEnableOption "Enable YubiKey support";
    };
  };

  config = lib.mkIf config.program.yubikey.enable {
    environment.systemPackages = with pkgs; [
      yubioath-flutter
      yubikey-manager
      pam_u2f
    ];

    services.pcscd = {
      enable = true;
    };
    #services.udev.packages = [pkgs.yubikey-personalization];
#
    #services.yubikey-agent.enable = true;
#
    #security.pam = {
    #  sshAgentAuth.enable = true;
    #  u2f = {
    #    enable = true;
    #    settings = {
    #      cue = false;
    #      authfile = "${config.home.homeDirectory}/.config/yubikeys/u2f_keys";
    #      # debug = true;
    #    };
    #  };
    #  services = {
    #    login.u2fAuth = true;
    #    sudo = {
    #      u2fAuth = true;
    #      sshAgentAuth = true;
    #    };
    #  };
    #};
  };
}
