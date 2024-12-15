{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options = {
    program.spotify.enable = lib.mkEnableOption "enable spotify";
  };

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  config = lib.mkIf config.program.spotify.enable {
    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];
      #theme = spicePkgs.themes.catppuccin;
      #colorScheme = "mocha";
    };
  };
}
