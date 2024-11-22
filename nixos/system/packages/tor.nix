{
  lib,
  config,
  ...
}: {
  options = {
    package.tor.enable = lib.mkEnableOption "Enable Tor";
    package.proxychains.enable = lib.mkEnableOption "Enable Proxychains";
  };

  config = lib.mkMerge [
    (lib.mkIf config.package.tor.enable {
      services.tor = {
        enable = true;
      };
      services.tor.client.enable = true;
    })
    (lib.mkIf config.package.proxychains.enable {
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
