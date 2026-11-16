{ config, pkgs, ... }:

{
  xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;
}

