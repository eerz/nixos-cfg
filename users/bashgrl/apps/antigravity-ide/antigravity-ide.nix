{
  config,
  lib,
  pkgs,
  ...
}: {
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  xdg.configFile."Antigravity IDE/User/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/users/bashgrl/apps/antigravity-ide/settings.json";

  xdg.configFile."Antigravity/User/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/users/bashgrl/apps/antigravity-ide/settings.json";

  xdg.desktopEntries.antigravity = {
    name = "Antigravity";
    genericName = "AI Code Editor";
    comment = "Next-Generation AI-Assisted IDE";
    exec = "antigravity --ozone-platform-hint=auto %F";
    icon = "antigravity";
    terminal = false;
    categories = [ "Development" "IDE" ];
    mimeType = [
      "text/plain"
      "inode/directory"
    ];
  };
}
