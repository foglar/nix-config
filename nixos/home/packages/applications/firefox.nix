{
  config,
  lib,
  inputs,
  pkgs,
  userSettings,
  ...
}: {
  options = {
    program.firefox.enable = lib.mkEnableOption "enable Firefox module";
  };

  config = lib.mkIf config.program.firefox.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox;

      profiles.default = {
        search.engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          "Phind" = {
            urls = [
              {
                template = "https://www.phind.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                  {
                    name = "searchMode";
                    value = "always";
                  }
                  {
                    name = "allowMultiSearch";
                    value = "false";
                  }
                ];
              }
            ];

            icon = "https://www.phind.com/favicon.ico";
            definedAliases = ["@phind"];
          };
        };
        search.force = true;

        settings = {
          "dom.security.https_only_mode" = true;
          "privacy.clearOnShutdown.history" = true;
          #"identity.fxaccounts.enabled" = false;
          #"signon.rememberSignons" = false;
        };

        bookmarks = [
          {
            name = "Toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "Server";
                bookmarks = [
                  {
                    name = "AudioBookshelf";
                    tags = ["audiobookshelf"];
                    keyword = "audio";
                    url = "http://foglar.local:8080";
                  }
                  {
                    name = "Photos";
                    tags = ["photoprism"];
                    keyword = "photos";
                    url = "http://foglar.local:2342";
                  }
                  {
                    name = "E-books";
                    tags = ["Kavita"];
                    keyword = "kavita";
                    url = "http://foglar.local:5000";
                  }
                  {
                    name = "Films";
                    tags = ["jellyfin"];
                    keyword = "films";
                    url = "http://foglar.local:8097";
                  }
                  {
                    name = "CasaOS";
                    tags = ["casaos"];
                    keyword = "casa";
                    url = "http://foglar.local:7788";
                  }
                  {
                    name = "Torrent";
                    tags = ["qbittorrent"];
                    keyword = "torrent";
                    url = "http://foglar.local:8181/";
                  }
                  {
                    name = "Syncthing";
                    tags = ["syncthing"];
                    keyword = "sync";
                    url = "https://foglar.local:8384/";
                  }
                  {
                    name = "Git";
                    tags = ["gitea"];
                    keyword = "git";
                    url = "https://git.foglar.tech";
                  }
                  {
                    name = "Vaultwarden";
                    tags = ["vaultwarden"];
                    keyword = "vault";
                    url = "https://vault.foglar.duckdns.org";
                  }
                ];
              }
            ];
          }
        ];

        extensions = with inputs.firefox-addons.packages."x86_64-linux";
          [
            ublock-origin
            # Lists all possible extensions $ nix-env -f '<nixpkgs>' -qaP -A nur.repos.rycee.firefox-addons
          ]
          ++ (
            if (userSettings.username == "shinya")
            then
              with inputs.firefox-addons.packages."x86_64-linux"; [
                #enhancer-for-youtube
                simple-translate
                duckduckgo-privacy-essentials
                return-youtube-dislikes
                user-agent-string-switcher
                privacy-badger
              ]
            else []
          );
      };
    };
  };
}
