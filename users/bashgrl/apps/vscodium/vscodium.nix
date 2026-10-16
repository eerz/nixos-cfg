{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      fill-labs.dependi
      vadimcn.vscode-lldb

      bbenoist.nix
      sumneko.lua

      catppuccin.catppuccin-vsc-icons
    ];
  };

  xdg.configFile."VSCodium/User/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/users/bashgrl/apps/vscodium/settings.json";
}
