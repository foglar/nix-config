# Kogami system profile

- This is my daily driver profile and template configuration for most people
- In [configuration.nix](./configuration.nix) you have system configuration settings.
- In [hardware-configuration.nix](./hardware-configuration.nix) is hardware configuration of the device you are installing this config, you should generate your own one with this command: `sudo nixos-generate-config --dir ~/.dotfiles/kogami`
- In [home.nix](./home.nix) you have user/home-manager configuration.