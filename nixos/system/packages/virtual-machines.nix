{
  config,
  lib,
  ...
}: {
  options = {
    package.virt-manager.enable = lib.mkEnableOption "Enable virt-manager";
  };
  config = lib.mkIf config.package.virt-manager.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
