{
  lib,
  config,
}: {
  options = {
    sys.bootloader.systemd-boot.enable = lib.mkEnableOption "Enable systemd-boot as the bootloader";
  };

  config = lib.mkIf config.sys.bootloader.systemd-boot.enable {
    boot.loader.systemd-boot.enable = true;
  };
}
