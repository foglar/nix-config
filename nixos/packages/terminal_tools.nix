{ 
  pkgs, 
  lib,
  config,
  ...
}:
{
  options = {
    terminal_tools.enable =
    lib.mkEnableOption "enable terminal tools module";
  };

    config = lib.mkIf config.terminal_tools.enable {

    programs = {
      bat.enable = true;
      btop.enable = true;
      fzf.enable = true;
      tmux.enable = true;
    };

    stylix.targets = {
      bat.enable = true;
      btop.enable = true;
      fzf.enable = true;
      neovim.enable = true;
      tmux.enable = true;
    };

    programs.oh-my-posh = {
      enable = true;
      enableBashIntegration = true;
      #settings = '''';
      #useTheme = "catppuccin_mocha";
      useTheme = "kali";
    };

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.kitty = {
    enable = true;
    font.name = lib.mkDefault "JetBrainsMono Nerd Font";
    #themeFile = "tokyo_night_night";
    #themeFile = "Catppuccin-Mocha";
    settings = {
      font_size = 11.5;
      confirm_os_window_close = 0;
      hide_window_decorations = 0;
      enable_audio_bell = false;
      window_padding_width = 25;
      };
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
      oh-my-posh
      eza
      nvtopPackages.full
      neofetch
      wget
      curl
      fzf
      tldr
      ranger
    ];
  };
}