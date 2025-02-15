{
  lib,
  config,
  pkgs,
  ...
}: let
  shellAliases = {
    ls = "${pkgs.eza}/bin/eza --icons";
    ll = "${pkgs.eza}/bin/eza -alh --icons";
    l = "${pkgs.eza}/bin/eza -lh  --icons=auto";
    tree = "${pkgs.eza}/bin/eza --tree --icons";
    neofetch = "${pkgs.fastfetch}/bin/fastfetch";
    open = "rifle";
    ip = "ip -c";
    s = "kitten ssh";
    icat = "kitten icat";
    diff = "diff --color";
    respawn = "clear; ${pkgs.pfetch}/bin/pfetch";
    mkdir = "mkdir -p";
    cat = "${pkgs.bat}/bin/bat --style plain";
    rasp = "s masaoka";
    hist = "history | awk '{for (i=2; i<=NF; i++) printf \$i\" \"; print \"\"}' | fzf | wl-copy";
    cdx = "${pkgs.zoxide}/bin/zoxide query --interactive";
    #distrobox-enter = "distrobox-enter --root";
    #distrobox-create = "distrobox-create --root";
    #distrobox-list = "distrobox-list --root";
  };
in {
  options = {
    sh.bash.enable = lib.mkEnableOption "enables shell bash";
    sh.zsh.enable = lib.mkEnableOption "enables shell zsh";
  };
  config = lib.mkMerge [
    (lib.mkIf config.sh.bash.enable {
      programs.bash = {
        enable = true;
        enableCompletion = true;

        shellAliases = shellAliases;

        bashrcExtra = ''
          ${pkgs.pfetch}/bin/pfetch'';
      };

      home.sessionVariables = {
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_PICTURES_DIR = "$HOME/Pictures/Screenshots/";
      };
    })
    (lib.mkIf config.sh.zsh.enable {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = shellAliases;

        initExtra = ''
          ${pkgs.pfetch}/bin/pfetch
          set -o emacs
          bindkey "^[[3~" delete-char'';
      };
    })
  ];
}
