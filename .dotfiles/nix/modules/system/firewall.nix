{ config, lib, pkgs, ... }:

{
  networking.firewall = {
    enable = true;

    # Block all unsolicited inbound
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];

    # Allow established connections 
    allowPing = false;

    # Extra protection
    logReversePathDrops = true;
  };
}
