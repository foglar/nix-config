{
  config,
  lib,
  ...
}: {
  options = {
    program.virt-manager.enable = lib.mkEnableOption "Enable virt-manager";
  };
  config = lib.mkIf config.program.virt-manager.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
