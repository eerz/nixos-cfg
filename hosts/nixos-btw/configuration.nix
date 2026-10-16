{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../users/bashgrl/user.nix

    ../../system/nix.nix
    ../../system/network.nix
    ../../system/audio.nix
    ../../system/nvidia.nix
    ../../system/hyprland/hyprland.nix
    ../../system/gaming.nix
    ../../system/fonts.nix
  ];

  networking.hostName = "nixos-btw";

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  time.timeZone = "Asia/Kolkata";
  time.hardwareClockInLocalTime = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };
  systemd.oomd.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
  ];

  services.hardware.bolt.enable = true;

  systemd.tmpfiles.rules = [
    "- /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode - - - - 1"
  ];

  services.thermald.enable = true;
  services.power-profiles-daemon.enable = true;
  powerManagement.cpuFreqGovernor = "performance";

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vpl-gpu-rt
  ];

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:2:0:0";
  };

  environment.sessionVariables = {
    AQ_DRM_DEVICES = "/dev/dri/by-path/pci-0000:02:00.0-card:/dev/dri/by-path/pci-0000:00:02.0-card";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  services.usbguard = {
    enable = true;
    implicitPolicyTarget = "block";
    presentDevicePolicy = "apply-policy";
    IPCAllowedUsers = [ "root" "bashgrl" ];

    rules = ''
      allow with-interface equals { 09:00:00 }

      allow id 152d:0583
      allow id 1609:3a04

      allow id 17ef:6135
      allow id 17ef:f006

      allow id 048d:c193
      allow id 048d:c197
      allow id 174f:11b5
      allow id 8087:0036
    '';
  };

  system.stateVersion = "26.05";
}
