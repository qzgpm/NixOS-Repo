{pkgs, ...}: {
  # Wipe the /root subvolume on every boot by rolling back to the blank snapshot.
  # Anything that must survive reboots must be declared in preservation.nix.
  #
  # Uses systemd initrd services — postDeviceCommands is not supported with
  # systemd stage 1 (which preservation enables).
  boot.initrd.systemd.services.rollback = {
    description = "Rollback BTRFS root subvolume to blank snapshot";
    wantedBy = ["initrd.target"];
    after = ["systemd-cryptsetup@cryptroot.service"];
    before = ["sysroot.mount"];
    unitConfig.DefaultDependencies = false;
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "rollback" ''
        mkdir /btrfs_tmp
        mount -o subvol=/ /dev/mapper/cryptroot /btrfs_tmp

        if [[ -e /btrfs_tmp/root ]]; then
          btrfs subvolume list -o /btrfs_tmp/root |
            cut -f9 -d' ' |
            while read subvolume; do
              echo "Deleting /$subvolume subvolume..."
              btrfs subvolume delete "/btrfs_tmp/$subvolume"
            done
          echo "Deleting /root subvolume..."
          btrfs subvolume delete /btrfs_tmp/root
        fi

        echo "Restoring blank /root subvolume..."
        btrfs subvolume snapshot /btrfs_tmp/root-blank /btrfs_tmp/root

        umount /btrfs_tmp
      '';
    };
  };
}
