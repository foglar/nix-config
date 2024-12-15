{
  lib,
  config,
  pkgs,
  userSettings,
  ...
}: {
  options = {
    sys.printing.enable = lib.mkEnableOption "Enable printing support";
  };

  config = lib.mkIf config.sys.printing.enable {
    services.printing.enable = true;
    services.printing.drivers = with pkgs; [gutenprint hplip splix];
    hardware.printers = {
      #ensurePrinters = [
      #  {
      #    name = "HP_psc_1200_series";
      #    location = "Home";
      #    deviceUri = "usb://HP/psc%201200%20series?serial=UA51SGB35WT0&interface=1";
      #    model = "HP_psc_1200_series.ppd";
      #    ppdOptions = {
      #      PageSize = "A4";
      #    };
      #  }
      #];
      #ensureDefaultPrinter = "HP_psc_1200_series";
    };

    # Scanning
    hardware.sane.enable = true;
    services.ipp-usb.enable = true;
    hardware.sane.extraBackends = [pkgs.hplipWithPlugin];

    users.users.${userSettings.username}.extraGroups = ["lp" "scanner"];
  };
}
