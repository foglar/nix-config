{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    hacking.enable = lib.mkEnableOption "enable Hacking module";
  };

  config = lib.mkIf config.hacking.enable {
    home.packages = with pkgs; [
      ffuf
      wireshark
      termshark
      nmap
      netcat-openbsd
      bettercap
      hashcat
      tcpdump
      sqlmap
      tor-browser
    ];
  };
}
