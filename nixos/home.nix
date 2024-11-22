{...}: {
  home.username = "foglar";
  home.homeDirectory = "/home/foglar";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ./packages/packages.nix
    ./desktop/desktops.nix
  ];

  desktop.hyprland.enable = true;
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

      respawn = "clear; pfetch";
      l = "eza -lh  --icons=auto";
      mkdir = "mkdir -p";
      cat = "bat --style plain";
      rasp = "s foglar@192.168.8.140";
      hist = "history | awk '{for (i=2; i<=NF; i++) printf \$i\" \"; print \"\"}' | fzf | wl-copy";
      packages = "paru -Qe | fzf | wl-copy";
      cdx = "zoxide query --interactive";

      distrobox-enter = "distrobox-enter --root";
      distrobox-create = "distrobox-create --root";
    };

    bashrcExtra = ''
      pfetch'';
  };

  home.file = {
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
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    FLAKE = "/home/foglar/dotfiles";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_PICTURES_DIR = "$HOME/Pictures/Screenshots/";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
