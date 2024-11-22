{pkgs, ...}: {
  # Printing
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

  users.users.foglar.extraGroups = ["lp" "scanner"];
}
