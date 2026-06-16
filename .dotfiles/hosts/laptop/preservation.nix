{...}: {
  preservation.preserveAt."/persist" = {
    files = [
      "/etc/machine-id"
      "/etc/shadow" # Preserve user password hashes across reboots
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];

    directories = [
      "/etc/nixos"
      "/root"
      "/home/dlvn/.ssh"
    ];
  };
}

