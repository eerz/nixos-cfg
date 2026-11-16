{ config, pkgs, ... }:

{
  imports = [
    ./apps/antigravity-ide
    ./apps/android-studio.nix
    ./apps/rustup.nix
    ./apps/firefox.nix
    ./apps/kitty.nix
    ./apps/awww.nix
    ./apps/hyprland
  ];

  home.username = "fabulous";
  home.homeDirectory = "/home/fabulous";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
