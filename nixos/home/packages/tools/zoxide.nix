{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    program.zoxide.enable = lib.mkEnableOption "zoxide";
  };

  config = lib.mkIf config.program.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    home.packages= with pkgs; [
      zoxide
    ];
  };
}
