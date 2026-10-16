{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  discordEnabled = true;
  vencordEnabled = true;
in {
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];

  programs.nixcord = {
    enable = discordEnabled;

    vesktop.enable = vencordEnabled;
    discord.enable = !vencordEnabled;

    config = lib.mkIf (discordEnabled && vencordEnabled) {
      useQuickCss = true;
      plugins = {
        volumeBooster.enable = true;
        callTimer.enable = true;

        noTrack.enable = true;
        clearURLs.enable = true;

        fakeNitro.enable = true;
        showHiddenChannels.enable = true;
        showHiddenThings.enable = true;
        unindent.enable = true;
        typingTweaks.enable = true;
        whoReacted.enable = true;
        memberCount.enable = true;
        permissionsFlavored.enable = true;
        relationshipNotifier.enable = true;
        youtubeAdblock.enable = true;
        openInApp.enable = true;
      };
    };
  };
}
