{lib, ...}: {
  # Wipe the /root subvolume on every boot by rolling back to the blank snapshot.
  # Anything that must survive reboots must be declared in preservation.nix.
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount -o subvol=/ /dev/mapper/cryptroot /btrfs_tmp

    if [[ -e /btrfs_tmp/root ]]; then
      btrfs subvolume list -o /btrfs_tmp/root |
        cut -f9 -d' ' |
        while read subvolume; do
          echo "Deleting /$subvolume subvolume..."
          btrfs subvolume delete "/btrfs_tmp/$subvolume"
        done &&
        echo "Deleting /root subvolume..." &&
        btrfs subvolume delete /btrfs_tmp/root
    fi

    echo "Restoring blank /root subvolume..."
    btrfs subvolume snapshot /btrfs_tmp/root-blank /btrfs_tmp/root

    umount /btrfs_tmp
  '';
}
