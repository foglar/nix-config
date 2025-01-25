{
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    program.vencord.enable =
      lib.mkEnableOption "Enable Vencord";
  };

  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];

  config = lib.mkIf config.program.vencord.enable {
    services.arrpc.enable = true;

    programs.nixcord = {
      enable = true; # enable Nixcord. Also installs discord package
      vesktop.enable = true; # enable Vesktop
      discord.enable = false; # enable Discord
      #quickCss = "some CSS";  # quickCSS file
      config = {
        #useQuickCss = true;   # use out quickCSS
        #themeLinks = [        # or use an online theme
        #  "https://raw.githubusercontent.com/link/to/some/theme.css"
        #];
        frameless = true; # set some Vencord options
        plugins = {
          anonymiseFileNames.enable = true;
          betterUploadButton.enable = true;
          clearURLs.enable = true;
          copyFileContents.enable = true;
          crashHandler.enable = true;
          decor.enable = true;
          emoteCloner.enable = true;
          fakeNitro.enable = true;
          fakeProfileThemes.enable = true;
          fixSpotifyEmbeds.enable = true;
          fixYoutubeEmbeds.enable = true;
          friendsSince.enable = true;
          iLoveSpam.enable = true;
          invisibleChat.enable = true;
          messageLogger.enable = true;
          noProfileThemes.enable = true;
          nsfwGateBypass.enable = true;
          openInApp.enable = true;
          permissionFreeWill.enable = true;
          pictureInPicture.enable = true;
          reverseImageSearch.enable = true;
          showConnections.enable = true;
          showHiddenChannels.enable = true;
          showHiddenThings.enable = true;
          showMeYourName.enable = true;
          silentTyping.enable = true;
          spotifyCrack.enable = true;
          typingIndicator.enable = true;
          webKeybinds.enable = true;
          webRichPresence.enable = true;
          webScreenShareFixes.enable = true;
          youtubeAdblock.enable = true;

          #ignoreActivities = {    # Enable a plugin and set some options
          #  enable = true;
          #  ignorePlaying = true;
          #  ignoreWatching = true;
          #  ignoredActivities = [ "someActivity" ];
          #};
        };
      };
      extraConfig = {
        # Some extra JSON config here
        # ...
      };
    };
  };
}

