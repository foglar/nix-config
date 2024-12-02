{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    programs.tmux.enable = lib.mkEnableOption "tmux";
  };

  config = lib.mkIf config.programs.tmux.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      terminal = "screen-256color";

      plugins = [
        pkgs.tmuxPlugins.dracula
        pkgs.tmuxPlugins.tpm
        #pkgs.tmuxPlugins.tmux-fzf
        pkgs.tmuxPlugins.sensible
        pkgs.tmuxPlugins.yank
        pkgs.tmuxPlugins.jump
      ];

      extraConfig = ''
        # Set switching between windows simpler
        unbind C-b
        set -g prefix C-Space
        bind C-Space send-prefix

        bind -n M-H previous-window
        bind -n M-L next-window

        set -g status-position top
        set-option -sa terminal-overrides ",xterm*:Tc"
        set-option -g mouse on

        set-window-option -g mode-keys vi
        setw -g mode-keys vi
        #keybindings for copying
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      '';
    };
  };
}
