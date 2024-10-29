{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./code.nix
    ./git.nix
  ];

  options = {
    programming.enable =
      lib.mkEnableOption "enable programming toolset";
  };

  config = lib.mkIf config.programming.enable {

    vscode.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;

    home.packages = with pkgs; [
      neovim
      arduino-ide
      go
      dotnet-sdk_8
      jq
    ];
  };
}
