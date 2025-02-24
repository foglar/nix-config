{
  pkgs,
  pkgs-stable,
  lib,
  config,
  userSettings,
  ...
}: {
  options = {
    program.vscode.enable = lib.mkEnableOption "enable vscode";

    program.vscode.ide.python.enable = lib.mkEnableOption "enable python for vscode";
    program.vscode.ide.go.enable = lib.mkEnableOption "enable go for vscode";
    program.vscode.ide.csharp.enable = lib.mkEnableOption "enable c# for vscode";
    program.vscode.ide.web.enable = lib.mkEnableOption "enable html and css for vscode";
    program.vscode.ide.cpp.enable = lib.mkEnableOption "enable cpp for vscode";

    program.vscode.nix.enable = lib.mkEnableOption "enable nix support for vscode";
    program.vscode.ai.enable = lib.mkEnableOption "enable ai copilot for vscode";
    program.vscode.git.enable = lib.mkEnableOption "enable git features for vscode";
    program.vscode.themes.enable = lib.mkEnableOption "enable themes for vscode";
    program.vscode.markdown.enable = lib.mkEnableOption "enable markdown for vscode";
  };

  config = lib.mkMerge [
    (lib.mkIf config.program.vscode.enable {
      home.packages = with pkgs; [
        vscode
      ];

      nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          # VSCODE
          "vscode"
          "vscode-extension-github-codespaces"
          "vscode-extension-ms-vscode-remote-remote-ssh"
          "vscode-extension-ms-vscode-remote-remote-ssh-edit"
          "vscode-extension-github-copilot"
          "vscode-extension-github-copilot-chat"
          "vscode-extension-MS-python-vscode-pylance"
          "vscode-extension-ms-dotnettools-csdevkit"
          "vscode-extension-ms-dotnettools-vscodeintellicode-csharp"
        ];

      programs.vscode = {
        enable = true;

        profiles.default.userSettings = {
          "files.autoSave" = "afterDelay";
          "explorer.confirmDragAndDrop" = false;
          #"editor.fontSize" = 16;
          "editor.minimap.side" = "right";
          "editor.scrollbar.vertical" = "hidden";
          "editor.scrollbar.verticalScrollbarSize" = 0;
          "editor.fontLigatures" = "'calt', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09', 'liga'";
          "editor.stickyScroll.enabled" = false;
          "security.workspace.trust.untrustedFiles" = "newWindow";
          "security.workspace.trust.startupPrompt" = "never";
          "security.workspace.trust.enabled" = false;
          "terminal.external.linuxExec" = "${pkgs.kitty}/bin/kitty";
          "terminal.integrated.stickyScroll.enabled" = true;
          "terminal.integrated.inheritEnv" = false;
          "telemetry.telemetryLevel" = "off";
          "workbench.activityBar.location" = "hidden"; # bottom
          "workbench.iconTheme" = "material-icon-theme";
          "workbench.productIconTheme" = "material-product-icons";
          "window.menuBarVisibility" = "toggle";
        };

        profiles.default.extensions = with pkgs-stable.vscode-extensions; [
          ms-azuretools.vscode-docker

          foxundermoon.shell-format
          tamasfe.even-better-toml
          aaron-bond.better-comments
          christian-kohler.path-intellisense

          github.codespaces

          nefrob.vscode-just-syntax

          # Remote
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.remote-ssh-edit

          pkief.material-product-icons
          pkief.material-icon-theme
        ];
      };
    })
    (lib.mkIf config.program.vscode.ide.python.enable {
      programs.vscode.profiles.default.userSettings = {
        "[python]" = {
          "editor.defaultFormatter" = "ms-python.black-formatter";
          "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
        };
      };

      programs.vscode.profiles.default.extensions = with pkgs-stable.vscode-extensions; [
        ms-python.python
        ms-python.vscode-pylance
        ms-python.black-formatter
        ms-python.debugpy
        njpwerner.autodocstring
        ms-toolsai.jupyter
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
      ];
    })

    (lib.mkIf config.program.vscode.ide.go.enable {
      programs.vscode.profiles.default.userSettings = {
        "go.alternateTools" = {
          "go-langserver" = "${pkgs.gopls}/bin/gopls";
        };
        "gopls" = {"ui.diagnostic.staticcheck" = true;};
      };

      home.sessionVariables = {
        GOOS = "linux";
        GOARCH = "amd64";
        GOPATH = "$HOME/.local/share/go";
      };

      programs.vscode.profiles.default.extensions = with pkgs-stable.vscode-extensions; [
        golang.go
      ];
    })

    (lib.mkIf config.program.vscode.ide.csharp.enable {
      programs.vscode.profiles.default.extensions = with pkgs-stable.vscode-extensions; [
        ms-dotnettools.csharp
        ms-dotnettools.csdevkit
        ms-dotnettools.vscodeintellicode-csharp
        ms-dotnettools.vscode-dotnet-runtime
      ];
    })

    (lib.mkIf config.program.vscode.nix.enable {
      programs.vscode.profiles.default.userSettings = {
        "nix.serverPath" = "nixd";
        "nix.enableLanguageServer" = true;
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = ["alejandra"]; # or nixfmt or nixpkgs-fmt
            };
            "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake \"~/.dotfiles/\").nixosConfigurations.${userSettings.hostname}.options";
              };
            };
            #    "home_manager": {
            #      "expr": "(builtins.getFlake \"/PATH/TO/FLAKE\").homeConfigurations..options"
            #    },
            # },
          };
        };
      };

      programs.vscode.profiles.default.extensions = with pkgs-stable.vscode-extensions; [
        jnoortheen.nix-ide
      ];
      home.packages = with pkgs-stable; [
        alejandra
        nixd
      ];
    })

    (lib.mkIf config.program.vscode.ide.web.enable {
      programs.vscode.profiles.default.userSettings = {
        "[json]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[html]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
      };

      programs.vscode.profiles.default.extensions = with pkgs-stable.vscode-extensions; [
        ritwickdey.liveserver
        esbenp.prettier-vscode
        ecmel.vscode-html-css
        ms-vscode.live-server
        formulahendry.auto-rename-tag
      ];
    })

    (lib.mkIf config.program.vscode.git.enable {
      programs.vscode.profiles.default.extensions = with pkgs-stable.vscode-extensions; [
        donjayamanne.githistory
        eamodio.gitlens
        github.vscode-pull-request-github
        github.vscode-github-actions
      ];

      programs.vscode.profiles.default.userSettings = {
        "git.autofetch" = true;
      };
    })

    (lib.mkIf config.program.vscode.markdown.enable {
      programs.vscode.profiles.default.userSettings = {
        "[markdown]" = {
          "editor.defaultFormatter" = "yzhang.markdown-all-in-one";
        };
      };

      programs.vscode.profiles.default.extensions = with pkgs-stable.vscode-extensions; [
        yzhang.markdown-all-in-one
        davidanson.vscode-markdownlint
      ];
    })

    (lib.mkIf config.program.vscode.themes.enable {
      programs.vscode.profiles.default.extensions = with pkgs-stable.vscode-extensions; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        zhuangtongfa.material-theme
        oderwat.indent-rainbow
        enkia.tokyo-night
      ];
    })

    (lib.mkIf config.program.vscode.ai.enable {
      programs.vscode.profiles.default.userSettings = {
        "github.copilot.editor.enableAutoCompletions" = true;
      };

      programs.vscode.profiles.default.extensions = with pkgs-stable.vscode-extensions; [
        github.copilot
        github.copilot-chat
      ];
    })

    (lib.mkIf config.program.vscode.ide.cpp.enable {
      programs.vscode.profiles.default.extensions = with pkgs-stable.vscode-extensions; [
        twxs.cmake
        ms-vscode.cmake-tools
      ];
    })
  ];
}
