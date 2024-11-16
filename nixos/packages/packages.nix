{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./programming/programming.nix
    ./hacking/hacking.nix
    ./games.nix
    ./terminal_tools.nix
    ./applications.nix
  ];

  terminal_tools.enable = lib.mkDefault true;
  programming.enable = lib.mkDefault true;
  games.enable = lib.mkDefault false;
  firefox.enable = lib.mkDefault true;
  applications.enable = lib.mkDefault true;
  hacking.enable = lib.mkDefault true;
  #programs.neovim.enable = true;

  home.packages = with pkgs; [
      alejandra
      nh
      nixd
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "spotify"

      "webstorm"
      "pycharm"
      "pycharm-professional"
      
      "steam"
      "steam-unwrapped"

      "gitkraken"

      # VSCODE
      "vscode"
      "vscode-extension-github-codespaces"
      "vscode-extension-ms-vscode-remote-remote-ssh"
      "vscode-extension-ms-vscode-remote-remote-ssh-edit"
      "vscode-extension-github-copilot"
      "vscode-extension-github-copilot-chat"
      "vscode-extension-MS-python-vscode-pylance"
      "vscode-extension-ms-dotnettools-csdevkit"
      "vscode-extension-ms-dotnettools-vscodeintellicode-csharp"

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
}
