{lib, ...}: {
  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = lib.mkDefault false;
  };

  boot.kernel.sysctl = {
    # Core protections
    "fs.suid_dumpable" = 0;
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
    "kernel.sysrq" = 0;

    # BPF hardening
    "kernel.unprivileged_bpf_disabled" = 1;
    "net.core.bpf_jit_harden" = 2;

    # Network hardening (strict mode for laptop)
    "net.ipv4.conf.all.rp_filter" = 2;
    "net.ipv4.conf.default.rp_filter" = 2;
    "net.ipv4.tcp_syncookies" = 1;

    # Extra info leak reduction
    "kernel.perf_event_paranoid" = 3;
  };

  security.sudo.wheelNeedsPassword = true;

  nix.settings = {
    sandbox = true;
    allowed-users = ["@wheel"];
  };
}
