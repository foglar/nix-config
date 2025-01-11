{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    app_list.terminal_tools.enable =
      lib.mkEnableOption "Enable terminal tools applist";
  };

  config = lib.mkIf config.app_list.terminal_tools.enable {
    home.packages = with pkgs;
      [
        btop
        cmatrix
        entr
        figlet
        jp2a
        yt-dlp
        wget
        curl
        fzf
        tldr
        ranger
        unzip
        fd
        imagemagick # convert images from formats like jpg, png, etc.
      ]
      ++ (
        if pkgs.system == "x86_64-linux"
        then [
          nvtopPackages.full
          toybox
        ]
        else []
      );

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        # NVTOP
        "nvtopPackages.full"
        "cuda-merged"
        "cuda_cuobjdump"
        "cuda_gdb"
        "cuda_nvcc"
        "cuda_nvdisasm"
        "cuda_nvprune"
        "cuda_cccl"
        "cuda_cudart"
        "cuda_cupti"
        "cuda_cuxxfilt"
        "cuda_nvml_dev"
        "cuda_nvrtc"
        "cuda_nvtx"
        "cuda_profiler_api"
        "cuda_sanitizer_api"
        "libcublas"
        "libcusolver"
        "libnvjitlink"
        "libcusparse"
        "libnpp"
        "libcufft"
        "libcurand"
      ];
  };
}
