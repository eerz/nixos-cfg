{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
  };

  xdg.configFile."kitty/kitty.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/users/bashgrl/apps/kitty/kitty.conf";
}
