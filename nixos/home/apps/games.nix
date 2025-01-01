{
  pkgs,
  pkgs-stable,
  lib,
  config,
  ...
}: {
  options = {
    app_list.games.enable =
      lib.mkEnableOption "enable games";
  };
  config = lib.mkIf config.app_list.games.enable {
    home.packages =
      (with pkgs; [
        vitetris
        steam
        superTuxKart
        wine

        (writeShellScriptBin "gs" ''
              set -xeuo pipefail

          gamescopeArgs=(
              --adaptive-sync # VRR support
              --hdr-enabled
              --mangoapp # performance overlay
              --rt
              --steam
          )
          steamArgs=(
              -pipewire-dmabuf
              -tenfoot
          )
          mangoConfig=(
              cpu_temp
              gpu_temp
              ram
              vram
          )
          mangoVars=(
              MANGOHUD=1
              MANGOHUD_CONFIG="$(IFS=,; echo "''${mangoConfig[*]}")"
          )

          export "''${mangoVars[@]}"
          exec gamescope "''${gamescopeArgs[@]}" -- steam "''${steamArgs[@]}"

        '')
      ])
      ++ (with pkgs-stable; [
        heroic
      ]);

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
        "steam-unwrapped"
      ];
  };
}
