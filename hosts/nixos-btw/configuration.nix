{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  users.users.fabulous = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "kvm" "dialout" ];
  };

  # Enable modern OpenGL / Vulkan graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load NVIDIA driver and blacklist nouveau (essential for RTX 5070 Ti)
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    # REQUIRED for RTX 50-series (Blackwell)
    open = true;

    # Laptop dynamic power management
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    nvidiaSettings = true;

    # Hybrid GPU routing (verified from your hardware)
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
    };
  };

  programs.nix-ld.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    # Force sharp subpixel anti-aliasing for Java/JetBrains/Android Studio
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true";
  };

  # System fonts & fontconfig rendering
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      jetbrains-mono
      noto-fonts
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting.style = "slight";
      subpixel.rgba = "rgb";
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    brightnessctl
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
