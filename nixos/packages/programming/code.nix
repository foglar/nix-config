{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    vscode.enable = lib.mkEnableOption "enable vscode";
  };

  config = lib.mkIf config.vscode.enable {
    home.packages = with pkgs; [
      vscode
      python3
      dotnet-sdk_8
    ];

    programs.vscode = {
      enable = true;

      userSettings = {
        "files.autoSave" = "afterDelay";
        "editor.fontSize" = 16;
        "editor.minimap.side" = "right";
        "editor.scrollbar.vertical" = "hidden";
        "editor.scrollbar.verticalScrollbarSize" = 0;
        "editor.fontLigatures" = "'calt', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09', 'liga'";
        "editor.stickyScroll.enabled" = false;
        "security.workspace.trust.untrustedFiles" = "newWindow";
        "security.workspace.trust.startupPrompt" = "never";
        "security.workspace.trust.enabled" = false;
        "terminal.external.linuxExec" = "kitty";
        "terminal.integrated.stickyScroll.enabled" = true;
        "telemetry.telemetryLevel" = "off";
        "workbench.activityBar.location" = "hidden"; # bottom
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.productIconTheme" = "material-product-icons";
        "window.menuBarVisibility" = "toggle";
        "github.copilot.editor.enableAutoCompletions" = false;
        "[json]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[python]" = {
          "editor.defaultFormatter" = "ms-python.black-formatter";
        };
        "python.defaultInterpreterPath" = "${pkgs.python3}";
        "nix.serverPath" = "nixd";
        "nix.enableLanguageServer" = true;
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = ["alejandra"]; # or nixfmt or nixpkgs-fmt
            };
            # "options": {
            #    "nixos": {
            #      "expr": "(builtins.getFlake \"~/mysystem/").nixosConfigurations.laptop.options"
            #    },
            #    "home_manager": {
            #      "expr": "(builtins.getFlake \"/PATH/TO/FLAKE\").homeConfigurations..options"
            #    },
            # },
          };
        };
      };

      extensions = with pkgs.vscode-extensions; [
        ms-azuretools.vscode-docker

        # Mardown
        yzhang.markdown-all-in-one
        davidanson.vscode-markdownlint

        foxundermoon.shell-format
        tamasfe.even-better-toml
        aaron-bond.better-comments
        christian-kohler.path-intellisense
        jnoortheen.nix-ide

        github.vscode-pull-request-github
        github.vscode-github-actions
        github.codespaces

        # Remote
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit

        # Webdev
        ritwickdey.liveserver
        esbenp.prettier-vscode
        ecmel.vscode-html-css
        ms-vscode.live-server
        formulahendry.auto-rename-tag

        # Ai
        github.copilot
        github.copilot-chat

        # Git
        donjayamanne.githistory
        eamodio.gitlens

        # Python
        ms-python.python
        ms-python.vscode-pylance
        ms-python.black-formatter
        ms-python.debugpy
        njpwerner.autodocstring
        ms-toolsai.jupyter
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers

        # Theme
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        zhuangtongfa.material-theme
        oderwat.indent-rainbow
        enkia.tokyo-night
        pkief.material-product-icons
        pkief.material-icon-theme

        # C/C++
        twxs.cmake
        ms-vscode.cmake-tools

        # C#
        ms-dotnettools.csharp
        ms-dotnettools.csdevkit
        ms-dotnettools.vscodeintellicode-csharp
        ms-dotnettools.vscode-dotnet-runtime

        # Go
        golang.go
      ];
    };
  };
}
