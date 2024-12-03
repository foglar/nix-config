{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    group.terminal_tools.enable =
      lib.mkEnableOption "enable terminal tools module";
  };

  imports = [
    ./tools/oh-my-posh.nix
    ./tools/shell.nix
    ./tools/kitty.nix
    ./tools/tmux.nix
    ./tools/zoxide.nix
  ];

  config = lib.mkIf config.group.terminal_tools.enable {
    
    sh.bash = {
      enable = lib.mkDefault true;
      oh-my-posh.enable = lib.mkDefault true;
    };

    program = {
      kitty.enable = lib.mkDefault true;
      tmux.enable = lib.mkDefault true;
      zoxide.enable = lib.mkDefault true;
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
      spicetify.enable = true;
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
