# Ginoza System Profile

- This is configuration profile for my old notebook that have only 32GB of space so it is pretty limited only to basic stuff
- It is usefull for experimenting, I am using it as a simple VM or testing lab
- I am only importing GNOME to this profile

> [!IMPORTANT]
> Don't forget that some configuration decisions should be set in [flake.nix](../flake.nix) file

## Configuration

- In [configuration.nix](./configuration.nix) you have system configuration settings.
- In [hardware-configuration.nix](./hardware-configuration.nix) is hardware configuration of the device you are installing this config, you should generate your own one with this command: `sudo nixos-generate-config --dir ~/.dotfiles/kogami`

| System configuration features                                  |
| -------------------------------------------------------------- |
| Systemd Boot                                                   |
| [GNOME](../nixos/system/settings/desktops.nix)                 |
| [GDM Login Manager](../nixos/system/settings/loginManager.nix) |
| [Stylix](../nixos/system/settings/style.nix)                   |

| Basics                                            |
| ------------------------------------------------- |
| [Audio](../nixos/system/settings/audio.nix)       |
| [Fonts](../nixos/system/settings/fonts.nix)       |
| [Network](../nixos/system/settings/network.nix)   |
| [Bluetooth](../nixos/system/settings/network.nix) |
| [Printing](../nixos/system/settings/printing.nix) |

| System packages and options |
| --------------------------- |
| KDE connect                 |

## Home Manager

- In [home.nix](./home.nix) you have user/home-manager configuration.
- Also I am using custom application lists in [apps](../nixos/home/apps/)

| Home configuration |
| ------------------ |
| Bash               |
| Firefox            |
| LibreOffice        |
