{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;

    rejectPackets = false;

    allowPing = false;

    checkReversePath = "strict";

    logRefusedConnections = true;

    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  boot.kernel.sysctl = {
    "net.ipv4.tcp_syncookies" = 1;

    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;

    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;

    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;

    "net.ipv4.icmp_echo_ignore_broadcasts" = 1;

    "net.ipv4.conf.all.log_martians" = 1;

    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";

    "net.ipv4.tcp_fastopen" = 3;

    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;
    "net.ipv4.tcp_rmem" = "4096 87380 16777216";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";
  };

  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    dnsovertls = "true";
    extraConfig = ''
      Cache=yes
      CacheMinTTLSec=60
    '';
  };
}
