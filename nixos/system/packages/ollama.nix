{
  lib,
  config,
  ...
}: {
  options.program.ollama.enable = lib.mkEnableOption "Enable Ollama";

  config = lib.mkIf config.program.ollama.enable {
    services.ollama = {
      enable = true;
      acceleration =
        if config.sys.nvidia.enable == true
        then "cuda"
        else "false";
    };
  };
}
