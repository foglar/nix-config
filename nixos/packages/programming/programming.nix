{
  pkgs,
  lib,
  config,
  ...
}: {

  options = {
    programming.enable =
      lib.mkEnableOption "enable programming toolset";
  };

  imports = [
    ./code.nix
    ./git.nix
  ];

  config = lib.mkIf config.programming.enable {
    
    vscode.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;

    home.packages = with pkgs; [
      neovim
      arduino-ide
      go
      jq
      conda
      jetbrains.webstorm
      jetbrains.pycharm-professional
      dotnet-sdk_8
      nodejs
      pnpm
    ];
  };
}
