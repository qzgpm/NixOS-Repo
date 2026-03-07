final: prev: let
  overlays = [
    (import ./suckless.nix)
  ];
in
  builtins.foldl' (acc: overlay: acc // overlay final prev) {} overlays
