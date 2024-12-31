{
  lib,
  config,
}: {
  options = {
    sys.bootloader.systemd.enable = lib.mkEnableOption "Enable systemd-boot as the bootloader";
  };

  config = lib.mkIf config.sys.bootloader.systemd.enable {
    boot.loader.systemd-boot.enable = true;
  };
}
