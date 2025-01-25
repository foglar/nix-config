{
  pkgs,
  lib,
  config,
  inputs,
  system,
  ...
}: {
  options = {
    app_list.programming.enable =
      lib.mkEnableOption "enable programming toolset";
  };

  config = lib.mkIf config.app_list.programming.enable {
    home.packages =
      (with pkgs; [
        arduino-ide
        distrobox
        go
        jq
        conda
        jetbrains.pycharm-professional
        dotnet-sdk_8
        git-ignore
        lazygit
        ghostty
      ]
      );

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "pycharm"
        "pycharm-professional"
      ];
  };
}
