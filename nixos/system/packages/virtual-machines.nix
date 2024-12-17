{
  config,
  lib,
  userSettings,
  ...
}: {
  options = {
    program.virt-manager.enable = lib.mkEnableOption "Enable virt-manager";
    program.virtualbox.enable = lib.mkEnableOption "Enable VirtualBox";
  };
  config = lib.mkMerge [
    (lib.mkIf config.program.virt-manager.enable {
      virtualisation.libvirtd.enable = true;
      programs.virt-manager.enable = true;
    })
    (lib.mkIf config.program.virtualbox.enable {
      virtualisation.virtualbox = {
        host.enable = true;
        guest = {
          enable = true;
          dragAndDrop = true;
        };
      };
      users.extraGroups.vboxusers.members = ["${userSettings.username}"];
    })
  ];
}
