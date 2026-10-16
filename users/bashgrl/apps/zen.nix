{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  zenPackage = inputs.zen-browser.packages."${pkgs.system}".default;

  enableCompactMode = true;
  enableVerticalTabs = true;
  enableSidebarAutoCollapse = false;
  enable240HzRefresh = true;
  enableVaapiHardwareDecode = true;
  enableSplitView = true;
  disableTelemetry = true;
in {
  home.packages = [
    zenPackage
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
  };

  xdg.desktopEntries.zen = {
    name = "Zen Browser";
    genericName = "Web Browser";
    exec = "zen %u";
    icon = "zen";
    terminal = false;
    categories = [ "Network" "WebBrowser" ];
    mimeType = [
      "text/html"
      "text/xml"
      "application/xhtml+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
  };

  home.file.".zen/default/user.js".text = ''
    user_pref("layout.frame_rate", ${if enable240HzRefresh then "240" else "60"});
    user_pref("general.smoothScroll", true);
    user_pref("layers.acceleration.force-enabled", true);

    user_pref("media.ffmpeg.vaapi.enabled", ${lib.boolToString enableVaapiHardwareDecode});
    user_pref("media.rdd-ffmpeg.enabled", true);
    user_pref("media.hardware-video-decoding.force-enabled", true);
    user_pref("widget.use-xdg-desktop-portal.file-picker", 1);
    user_pref("widget.use-xdg-desktop-portal.mime-handler", 1);

    user_pref("zen.view.compact-mode", ${lib.boolToString enableCompactMode});
    user_pref("zen.view.compact-toolbar", ${lib.boolToString enableCompactMode});
    user_pref("zen.tabs.vertical", ${lib.boolToString enableVerticalTabs});
    user_pref("zen.sidebar.auto-collapse", ${lib.boolToString enableSidebarAutoCollapse});
    user_pref("zen.splitView.enabled", ${lib.boolToString enableSplitView});

    user_pref("datareporting.policy.dataSubmissionEnabled", ${if disableTelemetry then "false" else "true"});
    user_pref("toolkit.telemetry.enabled", ${if disableTelemetry then "false" else "true"});
    user_pref("toolkit.telemetry.unified", ${if disableTelemetry then "false" else "true"});
    user_pref("browser.aboutConfig.showWarning", false);
    user_pref("browser.newtabpage.enabled", false);
    user_pref("browser.startup.homepage", "about:blank");
    user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
  '';
}
