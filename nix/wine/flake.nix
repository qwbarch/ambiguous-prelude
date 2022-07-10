{
  description = "Compatibility layer for windows programs.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    defaultPackage.x86_64-linux = with import nixpkgs {system = "x86_64-linux";};
      stdenv.mkDerivation rec {
        name = "wine-7.12";
        version = "7.12";
        #configureFlags = ["--enable-win64" "--without-freetype"];
        #buildInputs = [flex xorg.libX11 bison];
        buildInputs = [xorg.libX11];
        src = ./wine64-7.12.tar.gz;
        /*
        src = pkgs.fetchurl {
          url = "https://dl.winehq.org/wine/source/7.x/wine-7.12.tar.xz";
          sha256 = "sha256-gJzsE3FmNubq/Uw9pzEkVqhE0xYCClV4YRvNuiEGnGg=";
        };
        */
        nativeBuildInputs = [
          autoPatchelfHook
        ];
        dontConfigure = true;
        dontBuild = true;
        installPhase = ''
        install -m755 -D ./bin/wine64 $out/bin/wine64
        install -m755 -D ./bin/wine64-preloader $out/bin/wine64-preloader
        install -m755 -D ./bin/wineboot $out/bin/wineboot
        install -m755 -D ./bin/winebuild $out/bin/winebuild
        install -m755 -D ./bin/winecfg $out/bin/winecfg
        install -m755 -D ./bin/wineconsole $out/bin/wineconsole
        install -m755 -D ./bin/winecpp $out/bin/winecpp
        install -m755 -D ./bin/winedbg $out/bin/winedbg
        install -m755 -D ./bin/winedump $out/bin/winedump
        install -m755 -D ./bin/winefile $out/bin/winefile
        install -m755 -D ./bin/wineg++ $out/bin/wineg++
        install -m755 -D ./bin/winegcc $out/bin/winegcc
        install -m755 -D ./bin/winemaker $out/bin/winemaker
        install -m755 -D ./bin/winemine $out/bin/winemine
        install -m755 -D ./bin/winepath $out/bin/winepath
        install -m755 -D ./bin/wineserver $out/bin/wineserver
        ln -s $out/bin/wine64 $out/bin/wine

        mkdir -p $out/lib/wine
        cp -r ./lib/x86_64-unix $out/lib/wine/x86_64-unix
        cp -r ./lib/x86_64-windows $out/lib/wine/x86_64-windows

        mkdir -p $out/share/wine
        cp ./share/wine.inf $out/share/wine/wine.inf
        cp -r ./share/nls $out/share/wine/nls
        '';
      };
  };
}
