{
  lib,
  config,
  pkgs,
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
        #vim = "nvim";
        ls = "${pkgs.eza}/bin/eza --icons";
        ll = "${pkgs.eza}/bin/eza -alh --icons";
        l = "${pkgs.eza}/bin/eza -lh  --icons=auto";
        tree = "${pkgs.eza}/bin/eza --tree --icons";
        open = "rifle";
        ip = "ip -c";
        s = "kitten ssh";
        diff = "diff --color";
        respawn = "clear; ${pkgs.pfetch}/bin/pfetch";
        mkdir = "mkdir -p";
        cat = "${pkgs.bat}/bin/bat --style plain";
        rasp = "s foglar@192.168.8.140";
        hist = "history | awk '{for (i=2; i<=NF; i++) printf \$i\" \"; print \"\"}' | fzf | wl-copy";
        cdx = "${pkgs.zoxide}/bin/zoxide query --interactive";

        #distrobox-enter = "distrobox-enter --root";
        #distrobox-create = "distrobox-create --root";
        #distrobox-list = "distrobox-list --root";
      };

      bashrcExtra = ''
        ${pkgs.pfetch}/bin/pfetch'';
    };

    home.sessionVariables = {
      FLAKE = "/home/foglar/dotfiles";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_PICTURES_DIR = "$HOME/Pictures/Screenshots/";
    };
  };
}
