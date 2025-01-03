#!/bin/sh

if [ $# -gt 0 ]; then
    SCRIPT_DIR=$1
else
    SCRIPT_DIR=~/.dotfiles
fi

if [ -d $SCRIPT_DIR ]; then
    gum confirm "The directory $SCRIPT_DIR already exists. Do you want to delete it?" && yes | rm -rv $SCRIPT_DIR
fi

nixos_profile=$(gum choose kogami ginoza tsunemori)
download_wallpapers=$(gum confirm "Do you want to download wallpapers (it may take longer)?" && echo true || echo false)

if [ -d $SCRIPT_DIR ]; then
    gum warn "The directory $SCRIPT_DIR already exists. Downloading updates..."
    cd $SCRIPT_DIR && git pull
else
    nix-shell -p git --command "git clone https://git.foglar.tech/foglar/dotfiles.git $SCRIPT_DIR"
fi

sudo nixos-generate-config --show-hardware-config >$SCRIPT_DIR/kogami/hardware-configuration.nix
gum log --structured --level info "Creating hardware configuration..." file $SCRIPT_DIR/kogami/hardware-configuration.nix
sudo nixos-generate-config --show-hardware-config >$SCRIPT_DIR/ginoza/hardware-configuration.nix
gum log --structured --level info "Creating hardware configuration..." file $SCRIPT_DIR/kogami/hardware-configuration.nix

# Username
sed -i "0,/shinya/s//$(whoami)/" $SCRIPT_DIR/flake.nix
gum log --structured --level info "Setting user name in flake.nix..." file $SCRIPT_DIR/flake.nix
# Set hostname by selected profile
sed -i "0,/kogami/s//$profile/" $SCRIPT_DIR/flake.nix
gum log --structured --level info "Setting hostname in flake.nix..." file $SCRIPT_DIR/flake.nix
# Set dotfiles path as $SCRIPT_DIR path

# Editor
if [ -z $EDITOR ]; then
    EDITOR=nano
fi
gum log --structured --level info "Opening flake.nix in $EDITOR..." file $SCRIPT_DIR/flake.nix
$EDITOR $SCRIPT_DIR/flake.nix

gum log --structured --level info "Building configuration for $profile..." profile $profile
sudo nixos-rebuild build --flake $SCRIPT_DIR#"${profile}"

gum confirm "Do you want to reboot now?" && systemctl reboot || gum log "Please reboot later, to switch to the new configuration"
