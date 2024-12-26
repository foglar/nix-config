{userSettings, ...}: {
  # User configuration
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = "${userSettings.username}";
    extraGroups = ["wheel"];
    #! hashedPasswordFile = "password-hash";
    #! User Hashed password is stored in SOPS
    #! and is set in the module configuration
    #! file ../packages/sops/sops.nix
  };
}
