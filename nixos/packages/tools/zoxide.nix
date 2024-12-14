{
  lib,
  config,
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
  };
}
