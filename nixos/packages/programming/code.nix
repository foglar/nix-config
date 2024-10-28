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
    ];

    programs.vscode = {
      enable = true;

      userSettings = {
          "editor.fontSize" = 16;
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
