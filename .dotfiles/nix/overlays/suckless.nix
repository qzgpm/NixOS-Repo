self: super:

let
  commonX11Deps = [
    super.xorg.libX11
    super.xorg.libXft
    super.xorg.libXinerama
    super.xorg.libxcb
    super.xorg.xcbutil
  ];

  commonFontDeps = [
    super.fontconfig
    super.freetype
    super.harfbuzz
  ];

  mkSuckless = {
    name,
    src,
    bin,
    deps ? [],
    extraDeps ? [],
    homepage ? "https://${name}.suckless.org/",
    desc ? "Custom build of ${name}",
    extraInstall ? "",
  }:
    super.stdenv.mkDerivation {
      pname = "${name}_custom";
      version = "2025-08-29";

      src = super.lib.cleanSource src;

      dontConfigure = true;

      nativeBuildInputs = [ super.pkg-config ];

      buildInputs = deps ++ extraDeps;

      buildPhase = ''
        make clean
        make
      '';

      installPhase = ''
        mkdir -p $out/bin

        # Main binary
        cp -v ${bin} $out/bin/ || true

        # Any helper scripts (e.g. st-copyout, st-urlhandler, dmenu_run)
        find . -maxdepth 1 -type f -perm -u+x \
          -name "${bin}-*" -exec cp -v {} $out/bin/ \;

        # Man pages
        mkdir -p $out/share/man/man1
        cp -v *.1 $out/share/man/man1/ 2>/dev/null || true

        # Docs
        mkdir -p $out/share/doc/${name}
        cp -v LICENSE README* $out/share/doc/${name}/ 2>/dev/null || true

        ${extraInstall}
      '';

      meta = {
        description = desc;
        homepage = homepage;
        license = super.lib.licenses.mit;
        platforms = super.lib.platforms.linux;
        maintainers = [ super.lib.maintainers.your-name-here ];
      };
    };
in {
  dwm = mkSuckless {
    name = "dwm";
    src = ./dwm;
    bin = "dwm";
    deps = commonX11Deps;
    desc = "Dynamic window manager (custom build)";
  };

#  dmenu = mkSuckless {
#    name = "dmenu";
#    src = ./dmenu;
#    bin = "dmenu";
#    deps = commonX11Deps ++ commonFontDeps;
#    desc = "Dynamic menu (custom build)";
#    extraInstall = ''
#      cp -v dmenu_path dmenu_run $out/bin/ 2>/dev/null || true
#    '';
#  };

  st = mkSuckless {
    name = "st";
    src = ./st;
    bin = "st";
    deps = commonX11Deps ++ commonFontDeps;
    desc = "Simple terminal (custom build)";
    extraInstall = ''
      # Install terminfo
      mkdir -p $out/share/terminfo/s
      tic -s -o $out/share/terminfo st.info || true
    '';
  };

  dwmblocks = mkSuckless {
    name = "dwmblocks";
    src = ./dwmblocks;
    bin = "dwmblocks";
    deps = [ super.xorg.libX11 ];
    desc = "Modular status bar for dwm (custom build)";
  };
}
