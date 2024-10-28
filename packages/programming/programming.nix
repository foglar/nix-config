{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./code.nix
  ];

  options = {
    programming.enable =
      lib.mkEnableOption "enable programming toolset";
  };

  config = lib.mkIf config.programming.enable {
    programs.git = {
      enable = true;
      userName = "foglar";
      userEmail = "kohout.fi.2023@skola.ssps.cz";
    };

    vscode.enable = true;

    home.packages = with pkgs; [
      git
      neovim
      gitkraken
      arduino-ide
      github-cli
      go
      dotnet-sdk_8
      jq
    ];
  };
}
