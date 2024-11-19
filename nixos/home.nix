{...}: {
  home.username = "foglar";
  home.homeDirectory = "/home/foglar";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ./packages/packages.nix
    ./desktop/desktops.nix
  ];

  hyprland.enable = true;
  programming.enable = true;
  games.enable = true;

  gtk.enable = true;
  
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
      #arduino-cli = "arduino-ports-enable ; arduino-cli";
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

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/hypr/hyprlock.conf".source = ../config/hyprlock.conf;
    ".config/hypr/mocha.conf".source = ../config/mocha.conf;
    ".config/hypr/hypridle.conf".source = ../config/hypridle.conf;
    ".config/dolphinrc".source = ../config/dolphinrc;
    ".prettierrc".text = ''
      {
        "tabWidth": 4,
        "useTabs": true
      }
    '';

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    FLAKE = "/home/foglar/dotfiles";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_PICTURES_DIR = "$HOME/Pictures/Screenshots/";
    #FZF_DEFAULT_OPTS = " \
    #  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    #  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    #  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
  };

  #xdg.mimeApps = {
  #  enable = true;
  #  associations.added = {
  #    "application/pdf" = ["org.gnome.Evince.desktop"];
  #  };
  #  defaultApplications = {
  #    "application/pdf" = ["org.gnome.Evince.desktop"];
  #  };
  #};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
