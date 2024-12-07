{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    group.games.enable =
      lib.mkEnableOption "enables games";
  };
  config = lib.mkIf config.group.games.enable {
    home.packages = with pkgs; [
      vitetris
      steam
      superTuxKart
      heroic
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
    ];
  };
}
