{...}:
{
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

  services.tor = {
    enable = true;
  };
  services.tor.client.enable = true;
}