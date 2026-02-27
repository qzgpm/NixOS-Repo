self: super:

let
  commonX11Deps = with super.xorg; [
    libX11 libXft libXinerama libxcb
    xcbutil xcbutilimage xcbutilkeysyms xcbutilwm
    libXfixes xorgproto libXi
  ];

  commonFontDeps = with super; [
    fontconfig freetype harfbuzz
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
      version = "custom";

      src = super.lib.cleanSource src;

      strictDeps = true;
      dontConfigure = true;
      enableParallelBuilding = true;

      nativeBuildInputs = [ super.pkg-config ];
      buildInputs = deps ++ extraDeps;

      buildPhase = ''
        runHook preBuild
        make clean
        make
        runHook postBuild
      '';

      installPhase = ''
        runHook preInstall

        mkdir -p $out/bin
        cp -v ${bin} $out/bin/ || true

        find . -maxdepth 1 -type f -perm -u+x \
          -name "${bin}-*" -exec cp -v {} $out/bin/ \;

        mkdir -p $out/share/man/man1
        cp -v *.1 $out/share/man/man1/ 2>/dev/null || true

        mkdir -p $out/share/doc/${name}
        cp -v LICENSE README* $out/share/doc/${name}/ 2>/dev/null || true

        ${extraInstall}

        runHook postInstall
      '';

      meta = {
        description = desc;
        homepage = homepage;
        license = super.lib.licenses.mit;
        platforms = super.lib.platforms.linux;
        maintainers = [];
      };
    };

in {
  dwm = mkSuckless {
    name = "dwm";
    src = ./dwm;
    bin = "dwm";
    deps = commonX11Deps ++ commonFontDeps;
  };

  st = mkSuckless {
    name = "st";
    src = ./st;
    bin = "st";
    deps = commonX11Deps ++ commonFontDeps;

    extraInstall = ''
      mkdir -p $out/share/terminfo/s
      tic -s -o $out/share/terminfo st.info || true
    '';
  };

  dwmblocks = mkSuckless {
    name = "dwmblocks";
    src = ./dwmblocks;
    bin = "dwmblocks";
    deps = commonX11Deps ++ commonFontDeps;
  };
}
