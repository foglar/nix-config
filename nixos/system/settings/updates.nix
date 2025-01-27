{
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    sys.autoUpdate.enable = lib.mkEnableOption "Enable automatic updates";
    sys.autoCleanup.enable = lib.mkEnableOption "Enable automatic cleanup";
  };

  config = lib.mkMerge [
    (lib.mkIf config.sys.autoUpdate.enable {
      system.autoUpgrade = {
        enable = true;
        flake = inputs.self.outPath;
        flags = [
          "--commit-lock-file"
          "-L" # print build logs
        ];
        dates = "weekly";
        randomizedDelaySec = "45min";
      };
    })
    (lib.mkIf config.sys.autoCleanup.enable {
      nix = {
        gc ={
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 5d";
        };
        settings.auto-optimise-store = true;
      };
    })
  ];
}