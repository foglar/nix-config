{
  pkgs,
  lib,
  config,
  ...
  }:
{
  options = {
    programming.git.enable = lib.mkEnableOption "enable git";
  };

  config = lib.mkIf config.programming.git.enable {
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
