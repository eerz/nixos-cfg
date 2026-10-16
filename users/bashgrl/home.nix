{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  home.username = "bashgrl";
  home.homeDirectory = "/home/bashgrl";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  imports = [
    ./apps/kitty/kitty.nix
    ./apps/vscodium/vscodium.nix
    ./apps/antigravity-ide/antigravity-ide.nix
    ./apps/discord.nix
    ./apps/firefox.nix
    ./apps/zen.nix
    ./apps/rust.nix
    ./apps/spotify.nix
    ./apps/zoxide.nix
    ./apps/bash.nix
    ./apps/git.nix
  ];
}
