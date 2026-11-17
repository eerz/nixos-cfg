{ config, pkgs, inputs, ... }:

{
  home.packages = [
    inputs.antigravity.packages.${pkgs.stdenv.hostPlatform.system}.antigravity-fhs
  ];

  # Link user settings directly into the standard Antigravity configuration path
  xdg.configFile."Antigravity/User/settings.json".source = ./settings.json;
}
