{...}: {
  services.tlp = {
    enable = true;

    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      WIFI_PWR_ON_BAT = "on";
      PCIE_ASPM_ON_BAT = "powersupersave";
    };
  };

  # Must disable this (conflicts with TLP)
  services.power-profiles-daemon.enable = false;

  # Important for your 12th Gen Intel CPU
  services.thermald.enable = true;

  # Optional but recommended
  powerManagement.powertop.enable = true;
}
