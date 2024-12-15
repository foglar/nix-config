{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    sys.fonts.packages = pkgs.lib.mkEnableOption "Install fonts";
  };

  config = lib.mkIf config.sys.fonts.packages {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
      monaspace
    ];
  };
}
