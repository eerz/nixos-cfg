{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;

    profileExtra = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec Hyprland
      fi
    '';

    shellAliases = {
      c = "codium";
      a = "antigravity";

      rebuild = "sudo nixos-rebuild switch --flake ~/nix#nixos-btw";
      rebuild-boot = "sudo nixos-rebuild boot --flake ~/nix#nixos-btw";
      update = "nix flake update --flake ~/nix";

      la = "ls -la";
    };
  };
}
