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
      enable = true;
      vesktop.enable = true;
      discord.enable = false;
      config = {
        frameless = true;
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
        };
      };
    };
  };
}
