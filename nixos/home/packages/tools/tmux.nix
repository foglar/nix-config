{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    program.tmux.enable = lib.mkEnableOption "tmux";
  };

  config = lib.mkIf config.program.tmux.enable {
    stylix.targets.tmux.enable = true;

    programs.tmux = {
      enable = true;
      clock24 = true;
      terminal = "screen-256color";

      shortcut = "Space";

      plugins = [
        {
          plugin = pkgs.tmuxPlugins.dracula;
          extraConfig = ''
            #set -g @dracula-show-powerline true
            #set -g @dracula-show-flags true
            set -g @dracula-plugins "cpu-usage ram-usage battery time"
            set -g @dracula-show-left-icon session
            set -g @dracula-battery-colors "red dark_gray"
            set -g @dracula-show-timezone false
            set -g @dracula-day-month true
            set -g @dracula-military-time true
          '';
        }

        pkgs.tmuxPlugins.sensible
        pkgs.tmuxPlugins.yank
        #pkgs.tmuxPlugins.jump
        #pkgs.tmuxPlugins.tmux-fzf
      ];

      extraConfig = ''
        set-option -sa terminal-overrides ",xterm*:Tc"

        # Set pane to top
        set -g status-position top

        # Mouse enable
        set -g mouse on

        # Start count on 1 instead of 0
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1

        bind -n M-H previous-window
        bind -n M-L next-window

        # set vi mode
        set-window-option -g mode-keys vi
        setw -g mode-keys vi

        #keybindings for copying
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
      '';
    };
  };
}
