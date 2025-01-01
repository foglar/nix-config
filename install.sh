#!/bin/sh

echo "Running script"

if [ $# -gt 0 ]; then
    SCRIPT_DIR=$1
else
    SCRIPT_DIR=~/.dotfiles
fi

nix-shell -p git --command "git clone https://git.foglar.tech/foglar/dotfiles.git $SCRIPT_DIR"
sudo nixos-generate-config --show-hardware-config >$SCRIPT_DIR/kogami/hardware-configuration.nix
sudo nixos-generate-config --show-hardware-config >$SCRIPT_DIR/ginoza/hardware-configuration.nix

sed -i "0,/shinya/s//$(whoami)/" $SCRIPT_DIR/flake.nix

if [ -z $EDITOR ]; then
    EDITOR=nano
fi
$EDITOR $SCRIPT_DIR/flake.nix

profile=$(gum choose kogami ginoza)
sudo nixos-rebuild build --flake $SCRIPT_DIR#''"${profile}" --update

gum confirm "Do you want to switch to the new configuration?" && sudo nixos-rebuild switch --flake $SCRIPT_DIR#"${profile}"
gum confirm "Do you want to reboot now?" && systemctl reboot || echo "Please reboot later, to switch to the new configuration"
