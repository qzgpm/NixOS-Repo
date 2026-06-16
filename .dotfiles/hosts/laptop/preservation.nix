{...}: {
  preservation.preserveAt."/persist" = {
    files = [
      "/etc/machine-id"
    ];

    directories = [
      "/etc/nixos"

      "/root"

      "/home/dlvn/.ssh"

      "/var/lib/sops-nix"
    ];
  };
}
