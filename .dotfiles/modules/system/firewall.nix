{...}: {
  networking.firewall = {
    enable = true;

    # Block all unsolicited inbound
    allowedTCPPorts = [53317];
    allowedUDPPorts = [53317];

    # Allow established connections
    allowPing = false;

    # Extra protection
    logReversePathDrops = true;
  };
}
