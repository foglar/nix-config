{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    app_list.hacking.enable = lib.mkEnableOption "enable Hacking module";
  };

  config = lib.mkIf config.app_list.hacking.enable {
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
