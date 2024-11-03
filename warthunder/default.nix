{ pkgs ? import
    (builtins.fetchTarball {
      name = "nixpkgs-unstable-20241009165118";
      url = "https://github.com/NixOS/nixpkgs/archive/5633bcff0c6162b9e4b5f1264264611e950c8ec7.tar.gz";
      sha256 = "sha256-9UTxR8eukdg+XZeHgxW5hQA9fIKHsKCdOIUycTryeVw=";
    })
    { }
}:

let
  inherit (pkgs) buildFHSUserEnv;
in
buildFHSUserEnv {
  name = "launcher-fhs";
  targetPkgs = p: with p; [
    glib.out
    gtk3.out
    libgcc.lib
    xorg.libX11.out
    xorg.libXrandr.out
  ];
  runScript = "/home/foglar/Downloads/WarThunder/launcher";
}
