{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    games.enable =
      lib.mkEnableOption "enables games";
  };
  config = lib.mkIf config.games.enable {
    home.packages = with pkgs; [
      vitetris
      steam
      heroic
      gamescope
      wine

      (writeShellScriptBin "nvidia-offload" ''
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __VK_LAYER_NV_optimus=NVIDIA_only
        exec "$@"
      '')
    ];
  };
}
