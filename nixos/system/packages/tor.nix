{
  lib,
  config,
  ...
}: {
  options = {
    program.tor.enable = lib.mkEnableOption "Enable Tor";
    program.proxychains.enable = lib.mkEnableOption "Enable Proxychains";
  };

  config = lib.mkMerge [
    (lib.mkIf config.program.tor.enable {
      services.tor = {
        enable = true;
      };
      services.tor.client.enable = true;
    })
    (lib.mkIf config.program.proxychains.enable {
      programs.proxychains = {
        enable = true;
        chain.type = "dynamic";
        proxies = {
          tor-proxy = {
            enable = true;
            type = "socks5";
            host = "127.0.0.1";
            port = 9050;
          };
        };
      };
    })
  ];
}
