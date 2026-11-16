{ config, pkgs, inputs, ... }:

let
  stateDir = "${config.home.homeDirectory}/.local/state/apps/antigravity-ide";
  antigravityPkg = inputs.antigravity.packages.${pkgs.stdenv.hostPlatform.system}.antigravity-fhs;
in
{
  # Place settings.json inside the isolated app directory
  home.file.".local/state/apps/antigravity-ide/data/User/settings.json".source = ./settings.json;

  # Wrapper pointing runtime data & extensions into ~/.local/state/apps/antigravity-ide/
  home.packages = [
    (pkgs.writeShellScriptBin "antigravity-ide" ''
      mkdir -p "${stateDir}/data" "${stateDir}/extensions"
      exec ${antigravityPkg}/bin/antigravity-ide \
        --user-data-dir "${stateDir}/data" \
        --extensions-dir "${stateDir}/extensions" \
        "$@"
    '')
  ];
}
