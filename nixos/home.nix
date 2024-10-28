{lib, ...}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "foglar";
  home.homeDirectory = "/home/foglar";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ./packages.nix
    ./desktops.nix
  ];

  hyprland.enable = true;
  programming.enable = true;
  games.enable = true;

  services.dunst.enable = true;
  
  stylix.targets.bat.enable = true;
  stylix.targets.btop.enable = true;
  stylix.targets.dunst.enable = true;
  stylix.targets.fzf.enable = true;
  stylix.targets.neovim.enable = true;
  stylix.targets.tmux.enable = true;
  stylix.targets.waybar.enableCenterBackColors = false;
  stylix.targets.waybar.enableLeftBackColors = false;
  stylix.targets.waybar.enableRightBackColors = false;


  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      vim = "nvim";
      ls = "exa --icons";
      ll = "exa -alh --icons";
      tree = "exa --tree --icons";
      open = "rifle";
      ip = "ip -c";
      s = "kitten ssh";
      diff = "diff --color";
      cd = "z";
      arduino-cli = "arduino-ports-enable ; arduino-cli";
      respawn = "clear; pfetch";
      l = "eza -lh  --icons=auto";
      mkdir = "mkdir -p";
      cat = "bat --style plain";
      rasp = "s foglar@192.168.8.140";
      hist = "history | awk '{for (i=2; i<=NF; i++) printf \$i\" \"; print \"\"}' | fzf | wl-copy";
      packages = "paru -Qe | fzf | wl-copy";
      cdx = "zoxide query --interactive";
    };

    bashrcExtra = ''
      pfetch'';
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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/foglar/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    FLAKE = "/home/foglar/mysystem";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_PICTURES_DIR = "$HOME/Pictures/Screenshots/";
    FZF_DEFAULT_OPTS = " \
      --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
