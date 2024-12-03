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
    
    program.vscode.enable = lib.mkDefault true;
    program.git.enable = lib.mkDefault true;

    home.packages = with pkgs; [
      neovim
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
