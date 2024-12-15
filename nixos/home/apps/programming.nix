{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    app_list.programming.enable =
      lib.mkEnableOption "enable programming toolset";
  };

  config = lib.mkIf config.app_list.programming.enable {
    home.packages = with pkgs; [
      arduino-ide
      distrobox
      go
      jq
      conda
      jetbrains.pycharm-professional
      dotnet-sdk_8
      nodejs
      pnpm
    ];
  };
}
