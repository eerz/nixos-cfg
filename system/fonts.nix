{
  config,
  lib,
  pkgs,
  ...
}: {
  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      font-awesome
    ];

    defaultFonts = {
      monospace = [ "DejaVu Sans Mono" "Noto Sans Mono" ];
      sansSerif = [ "DejaVu Sans" "Noto Sans" ];
      serif = [ "DejaVu Serif" "Noto Serif" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
