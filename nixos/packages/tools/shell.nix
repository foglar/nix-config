{
  lib,
  config,
  ...
}: {
  options = {
    sh.bash.enable =
      lib.mkEnableOption "enables shell tools";
  };

  config = lib.mkIf config.sh.bash.enable {
    
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
        cdx = "zoxide query --interactive";

        distrobox-enter = "distrobox-enter --root";
        distrobox-create = "distrobox-create --root";
        distrobox-list = "distrobox-list --root";
      };

      bashrcExtra = ''
        pfetch'';
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      FLAKE = "/home/foglar/dotfiles";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_PICTURES_DIR = "$HOME/Pictures/Screenshots/";
    };
  };
}
