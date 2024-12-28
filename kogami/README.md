# Kogami system profile

- This is my daily driver profile and template configuration for most people

> [!IMPORTANT]
> Don't forget that some configuration decisions should be set in [flake.nix](../flake.nix) file

## Configuration

- In [configuration.nix](./configuration.nix) you have system configuration settings.
- In [hardware-configuration.nix](./hardware-configuration.nix) is hardware configuration of the device you are installing this config, you should generate your own one with this command: `sudo nixos-generate-config --dir ~/.dotfiles/kogami`

| System configuration features                                    |
| ---------------------------------------------------------------- |
| Systemd Boot                                                     |
| [Hyprland](../nixos/system/settings/desktops.nix)                |
| [SDDM Login Manager](../nixos/system/settings/loginManager.nix)  |
| [NVIDIA PRIME Offload mode](../nixos/system/settings/nvidia.nix) |
| [Stylix](../nixos/system/settings/style.nix)                     |
| nix-ld                                                           |

| Basics                                            |
| ------------------------------------------------- |
| [Audio](../nixos/system/settings/audio.nix)       |
| [Fonts](../nixos/system/settings/fonts.nix)       |
| [Network](../nixos/system/settings/network.nix)   |
| [Bluetooth](../nixos/system/settings/network.nix) |
| [Printing](../nixos/system/settings/printing.nix) |

| System packages and options                                      |
| ---------------------------------------------------------------- |
| [Podman](../nixos/system/packages/podman.nix)                    |
| [Steam](../nixos/system/packages/steam.nix)                      |
| [Proxychains](../nixos/system/packages/tor.nix)                  |
| [Tor](../nixos/system/packages/tor.nix)                          |
| [Virtual Manager](../nixos/system/packages/virtual-machines.nix) |
| [Yubikey](../nixos/system/packages/yubikey.nix)                  |
| [SSH client](../nixos/system/packages/ssh-client.nix)            |
| KDE connect                                                      |
| Wireshark                                                        |
| Auto-CPUFreq                                                     |

## Home Manager

- In [home.nix](./home.nix) you have user/home-manager configuration.
- Also I am using custom application lists in [apps](../nixos/home/apps/)

| Home configuration |
| ------------------ |
| Zsh                |
| Bash               |
| Oh-My-Posh         |
| Kitty              |
| Tmux               |
| Zoxide             |
| VSCode             |
| Git                |
| Neovim             |
| Firefox            |
| Spotify            |
| Bat                |
| Btop               |
| Fzf                |
