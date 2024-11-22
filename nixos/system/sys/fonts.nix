{pkgs, ...}: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    monaspace
  ];
}
