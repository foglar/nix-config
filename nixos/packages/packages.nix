{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./programming/programming.nix
    ./games.nix
    ./terminal_tools.nix
    ./applications/firefox.nix
    #./packages/applications.nix
  ];

  terminal_tools.enable = lib.mkDefault true;
  programming.enable = lib.mkDefault true;
  games.enable = lib.mkDefault false;
  firefox.enable = lib.mkDefault true;
  #programs.neovim.enable = true;

  home.packages = with pkgs; [
    librewolf
    vesktop

    alejandra
    nh
    nixd

    stellarium
    libreoffice
    localsend
    plasma5Packages.kdeconnect-kde
    qbittorrent
    vlc
    #tor-browser
    openrocket
    spotify
    inkscape

    #zed-editor
    #gtk3
    #(python3.withPackages (subpkgs: with subpkgs; [
    #pygobject3
    #gobject-introspection
    #astropy
    #tomli
    #tomli-w
    #matplotlib
    #basemap
    #opencv4
    #requests
    #]))

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "spotify"
      "steam"
      "steam-unwrapped"

      "enhancer-for-youtube"

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
