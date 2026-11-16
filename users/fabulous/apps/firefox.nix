{ config, pkgs, ... }:

let
  stateDir = "${config.home.homeDirectory}/.local/state/apps/firefox";
in
{
  home.packages = [
    (pkgs.writeShellScriptBin "firefox" ''
      mkdir -p "${stateDir}/profile"
      exec ${pkgs.firefox}/bin/firefox \
        --profile "${stateDir}/profile" \
        "$@"
    '')
  ];

  # Desktop launcher entry to use our isolated profile wrapper
  xdg.desktopEntries.firefox = {
    name = "Firefox";
    genericName = "Web Browser";
    exec = "firefox %U";
    icon = "firefox";
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
}

