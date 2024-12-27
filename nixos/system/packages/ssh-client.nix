{
  lib,
  config,
  ...
}: {
  options = {
    program.ssh.client.enable = lib.mkEnableOption "enable SSH client configuration";
  };
  config = lib.mkIf config.program.ssh.client.enable {
    programs.ssh = {
      extraConfig = ''
        Host masaoka
          HostName 192.168.8.140
          User foglar
          IdentityFile ~/.ssh/id_masaoka
      '';
    };
  };
}
