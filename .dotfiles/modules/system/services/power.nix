{...}: {
  services.tlp = {
    enable = true;

    settings = {
      # ─────────────────────────────────────────────
      # CPU (modern AMD best practice)
      # ─────────────────────────────────────────────

      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;

      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 1;

      # ─────────────────────────────────────────────
      # Platform profile (Lenovo EC control)
      # ─────────────────────────────────────────────

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";

      # ─────────────────────────────────────────────
      # Power management thresholds (battery health)
      # ─────────────────────────────────────────────

      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;

      # ─────────────────────────────────────────────
      # PCIe / Runtime Power Management
      # ─────────────────────────────────────────────

      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersave";

      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";

      # ─────────────────────────────────────────────
      # Wi-Fi / USB
      # ─────────────────────────────────────────────

      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      USB_AUTOSUSPEND = 1;

      # ─────────────────────────────────────────────
      # Audio power saving
      # ─────────────────────────────────────────────

      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";
    };
  };

  # Conflicts — must stay disabled
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = false;

  # AMD modern scheduler
  boot.kernelParams = [
    "amd_pstate=active"
    "pcie_aspm=force"
  ];
}
