{ config, pkgs, ... }:

let
  stateDir = "${config.home.homeDirectory}/.local/state/apps/android-studio";

  ideaProperties = pkgs.writeText "idea.properties" ''
    idea.config.path=${stateDir}/config
    idea.system.path=${stateDir}/system
    idea.plugins.path=${stateDir}/plugins
    idea.log.path=${stateDir}/system/log
  '';
in
{
  home.packages = [
    (pkgs.writeShellScriptBin "android-studio" ''
      mkdir -p "${stateDir}/config" "${stateDir}/system" "${stateDir}/plugins" \
               "${stateDir}/android" "${stateDir}/sdk" "${stateDir}/gradle"

      export STUDIO_PROPERTIES="${ideaProperties}"
      export ANDROID_USER_HOME="${stateDir}/android"
      export ANDROID_HOME="${stateDir}/sdk"
      export ANDROID_SDK_ROOT="${stateDir}/sdk"
      export GRADLE_USER_HOME="${stateDir}/gradle"

      exec ${pkgs.android-studio}/bin/android-studio "$@"
    '')
  ];
}

