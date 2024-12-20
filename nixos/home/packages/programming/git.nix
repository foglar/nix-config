{
  pkgs,
  lib,
  config,
  userSettings,
  ...
}: {
  options = {
    program.git.enable = lib.mkEnableOption "enable git";
  };

  config = lib.mkIf config.program.git.enable {
    programs.git = {
      enable = true;
      userName = "${userSettings.username}";
      userEmail = "kohout.fi.2023@skola.ssps.cz";
    };

    home.packages = with pkgs; [
      git
      github-cli
      gitkraken
    ];
  };
}
