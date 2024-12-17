{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    app_list.terminal_tools.enable =
      lib.mkEnableOption "Enable terminal tools applist";
  };

  config = lib.mkIf config.app_list.terminal_tools.enable {

    home.packages = with pkgs; [
      btop
      cmatrix
      entr
      figlet
      jp2a
      yt-dlp
      nvtopPackages.full
      neofetch
      wget
      curl
      fzf
      tldr
      ranger
      unzip
    ];
  };
}
