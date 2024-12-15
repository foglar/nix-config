{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./programming/code.nix
    ./programming/git.nix
    ./programming/neovim.nix

    ../apps/hacking.nix
    ../apps/games.nix
    ../apps/applications.nix
    ../apps/terminal_tools.nix
    ../apps/programming.nix

    ./applications/firefox.nix
    ./applications/spotify.nix

    ./tools/oh-my-posh.nix
    ./tools/shell.nix
    ./tools/kitty.nix
    ./tools/tmux.nix
    ./tools/zoxide.nix
  ];

  sh.bash = {
    enable = lib.mkDefault true;
    oh-my-posh.enable = lib.mkDefault true;
  };

  program = {
    kitty.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;

    firefox.enable = lib.mkDefault true;
    spotify.enable = lib.mkDefault true;

    vscode.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    neovim.enable = lib.mkDefault true;
  };

  app_list = {
    terminal_tools.enable = lib.mkDefault true;
    programming.enable = lib.mkDefault true;
    games.enable = lib.mkDefault false;
    applications.enable = lib.mkDefault true;
    hacking.enable = lib.mkDefault true;
  };

  programs = {
    bat.enable = lib.mkDefault true;
    btop.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
  };

  stylix.targets = {
    bat.enable = lib.mkDefault true;
    btop.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    neovim.enable = lib.mkDefault true;
  };

  home.packages = with pkgs; [
    alejandra
    nh
    nixd
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "spotify"

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
