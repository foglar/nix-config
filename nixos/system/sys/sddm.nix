{
  pkgs,
  lib,
  ...
}:
{

  services.displayManager = {
    defaultSession = "hyprland";
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      package = lib.mkDefault pkgs.kdePackages.sddm;
      extraPackages = [pkgs.sddm-astronaut pkgs.kdePackages.qtvirtualkeyboard];
    };
  };

  environment.systemPackages = with pkgs; [
    (sddm-astronaut.override {
      themeConfig = {
        ScreenWidth = 1920;
        ScreenHeight = 1080;
        PartialBlur = false;
      };
    })
  ];
}