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
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      monaspace
    ];
  };
}
