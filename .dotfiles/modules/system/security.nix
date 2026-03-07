{lib, ...}: {
  # Kernel hardening / security features
  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = lib.mkDefault false;
  };
  security.rtkit.enable = true; # realtime scheduling

  # Doas
  security.doas = {
    enable = true;
    extraRules = [
      {
        users = ["dlvn"];
        keepEnv = true;
        persist = true;
      }
    ];
  };

  # Kernel sysctl hardening
  boot.kernel.sysctl = {
    "fs.suid_dumpable" = 0;
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
    "kernel.sysrq" = 0;

    # BPF hardening
    "kernel.unprivileged_bpf_disabled" = 1;
    "net.core.bpf_jit_harden" = 2;

    # Network hardening
    "net.ipv4.conf.all.rp_filter" = 2;
    "net.ipv4.conf.default.rp_filter" = 2;
    "net.ipv4.tcp_syncookies" = 1;

    # Extra info leak reduction
    "kernel.perf_event_paranoid" = 3;
  };
}
