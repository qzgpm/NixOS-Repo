{...}: {
  boot = {
    loader = {
      #No of generation to chose
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };

    # Memory hardening flags
    kernelParams = [
      "slab_nomerge"
      "init_on_alloc=1"
      "init_on_free=1"
      "page_alloc.shuffle=1"
    ];

    # Rarely used network protocols
    blacklistedKernelModules = [
      "dccp"
      "sctp"
      "rds"
      "tipc"
    ];
  };
}
