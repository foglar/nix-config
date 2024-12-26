# dotfiles

- my personal nix dotfiles in the **flake**

- simple build command for system

```bash
git clone https://git.foglar.tech/foglar/dotfiles.git $HOME/dotfiles 
sudo nixos-rebuild switch --flake ~/dotfiles#laptop
```

- generate a vm of the flake with this command

```bash
nix run github:nix-community/nixos-generators -- -c ./flake.nix --flake '#leanix' -f vm --disk-size 20480 
```

- deploy configuration on the new system

```bash
# Copy my repository
git clone https://git.foglar.tech/foglar/dotfiles.git $HOME/dotfiles --depth 1

# Generate your own hardware configurations for system
sudo nixos-generate-config --dir ~/dotfiles/zenith
# or
sudo nixos-generate-config --dir ~/dotfiles/leanix

# Rebuild your system from the flake
sudo nixos-rebuild switch --flake ~/dotfiles#zenith
```

## Features
