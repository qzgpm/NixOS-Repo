{...}: {
  networking = {
    hostName = "me";

    networkmanager = {
      enable = true;
      settings = {
        "main" = {
          dns = "none";
        };
      };
    };

    #Cloudflare DNS
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };

  time.timeZone = "Asia/Kolkata";
}
