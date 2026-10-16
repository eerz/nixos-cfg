{
  pkgs,
  ...
}: {
  users.users.bashgrl = {
    isNormalUser = true;
    description = "bashgrl";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
    ];
    shell = pkgs.bash;
  };

  home-manager.users.bashgrl = import ./home.nix;
}
