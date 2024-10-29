{
  pkgs,
  lib,
  config,
  ...
  }:
{
  options = {
    git.enable = lib.mkEnableOption "enable git";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = "foglar";
      userEmail = "kohout.fi.2023@skola.ssps.cz";
    };

    home.packages = with pkgs; [
      git
      github-cli
      gitkraken
    ];
  };
}
