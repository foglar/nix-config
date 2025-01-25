{
  lib,
  config,
  ...
}: {
  options = {
    program.ranger.enable =
      lib.mkEnableOption "Enable ranger";
  };

  config = lib.mkIf config.program.ranger.enable {
    programs.ranger = {
      enable = true;
      extraConfig = ''
        set preview_images true
        set preview_images_method kitty
      '';
    };
  };
}