# dotfiles

- my personal nix dotfiles in flake

```bash
git clone https://git.foglar.tech/foglar/dotfiles.git $HOME/dotfiles --depth 1 
sudo nixos-rebuild switch --flake ~/dotfiles#laptop
```

```bash
nix run github:nix-community/nixos-generators -- -c ./flake.nix --flake '#leanix' -f vm --disk-size 20480 
```

## Features
