# dotfiles

- my personal nix dotfiles in the **flake**

## Build and deploy

- simple build command for system

```bash
git clone https://git.foglar.tech/foglar/dotfiles.git $HOME/.dotfiles 
sudo nixos-rebuild switch --flake ~/.dotfiles#kogami
```

- generate a vm of the flake with this command

```bash
nix run github:nix-community/nixos-generators -- -c ./flake.nix --flake '#ginoza' -f vm --disk-size 20480 
```

- deploy configuration on the new system

```bash
# Copy my repository
git clone https://git.foglar.tech/foglar/dotfiles.git $HOME/.dotfiles --depth 1

# Generate your own hardware configurations for system
sudo nixos-generate-config --dir ~/.dotfiles/kogami
# or
sudo nixos-generate-config --dir ~/.dotfiles/ginoza

# Rebuild your system from the flake
sudo nixos-rebuild switch --flake ~/.dotfiles#kogami
```

## Features

### Secure Operations

- file for sops is in **~/.config/sops/ags/keys.txt**

### Yubikey

- setup your yubikey to work with current user

```bash
nix-shell -p yubico-pam -p yubikey-manager
ykman otp chalresp --touch --generate 2
ykpamcfg -2 -v
```
