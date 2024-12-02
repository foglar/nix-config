{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    terminal_tools.enable =
      lib.mkEnableOption "enable terminal tools module";
  };

  imports = [
    ./tools/oh-my-posh.nix
    ./tools/shell.nix
    ./tools/kitty.nix
    ./tools/tmux.nix
  ];

  config = lib.mkIf config.terminal_tools.enable {
    
    sh.bash = {
      enable = lib.mkDefault true;
      oh-my-posh.enable = lib.mkDefault true;
    };

    program = {
      kitty.enable = lib.mkDefault true;
      tmux.enable = lib.mkDefault true;
    };

    programs = {
      bat.enable = true;
      btop.enable = true;
      fzf.enable = true;
    };

    stylix.targets = {
      bat.enable = true;
      btop.enable = true;
      fzf.enable = true;
      neovim.enable = true;
      tmux.enable = true;
      spicetify.enable = true;
    };

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    home.packages = with pkgs; [
      pfetch
      zoxide
      bat
      btop
      cmatrix
      entr
      figlet
      jp2a
      yt-dlp
      eza
      nvtopPackages.full
      neofetch
      wget
      curl
      fzf
      tldr
      ranger
      spicetify-cli
      unzip
    ];
  };
}
