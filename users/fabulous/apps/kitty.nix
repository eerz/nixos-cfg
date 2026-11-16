{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      # Disable exit confirmation prompt
      confirm_os_window_close = 0;
    };
  };
}

