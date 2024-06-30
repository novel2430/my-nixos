{ pkgs, nix23-pkgs, custom-pkgs, ... }:
let
  lib = pkgs.lib;
  # gtk-4-12-5 = nix23-pkgs.gtk4.overrideAttrs (final: prev : with pkgs; rec {
  #   version = "4.12.5";
  #   src = fetchurl {
  #     url = "mirror://gnome/sources/gtk/${lib.versions.majorMinor final.version}/gtk-${final.version}.tar.xz";
  #     hash = "sha256-KLNW1ZDuaO9ibi75ggst0hRBSEqaBCpaPwxA6d/E9Pg=";
  #   };
  # });
  gtk-4-12-5 = pkgs.gtk4.overrideAttrs (final: prev : with pkgs; rec {
    pname = "gtk4";
    version = "4.12.5";

    src = fetchurl {
      url = "mirror://gnome/sources/gtk/${lib.versions.majorMinor final.version}/gtk-${final.version}.tar.xz";
      hash = "sha256-KLNW1ZDuaO9ibi75ggst0hRBSEqaBCpaPwxA6d/E9Pg=";
    };

    nativeBuildInputs = [
      gettext
      gobject-introspection
      makeWrapper
      meson
      ninja
      pkg-config
      python3
      sassc
      gi-docgen
      libxml2 # for xmllint
    ] ++ lib.optionals (stdenv.hostPlatform.emulatorAvailable buildPackages && !stdenv.buildPlatform.canExecute stdenv.hostPlatform) [
      mesonEmulatorHook
    ] ++ lib.optionals (stdenv.isLinux) [
      wayland-scanner
    # ] ++ lib.optionals vulkanSupport [
    #   shaderc # for glslc
    ] ++ prev.setupHooks;

    postPatch = ''
      # this conditional gates the installation of share/gsettings-schemas/.../glib-2.0/schemas/gschemas.compiled.
      substituteInPlace meson.build \
        --replace 'if not meson.is_cross_build()' 'if ${lib.boolToString (stdenv.hostPlatform.emulatorAvailable buildPackages)}'

      files=(
        build-aux/meson/gen-demo-header.py
        build-aux/meson/gen-visibility-macros.py
        demos/gtk-demo/geninclude.py
        gdk/broadway/gen-c-array.py
        gdk/gen-gdk-gresources-xml.py
        gtk/gen-gtk-gresources-xml.py
        gtk/gentypefuncs.py
      )

      chmod +x ''${files[@]}
      patchShebangs ''${files[@]}
    '';

    postFixup =  lib.optionalString (!stdenv.isDarwin) ''
      demos=(gtk4-demo gtk4-demo-application gtk4-icon-browser gtk4-widget-factory)

      for program in ''${demos[@]}; do
        wrapProgram $dev/bin/$program \
          --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH:$out/share/gsettings-schemas/${pname}-${version}"
      done
    '' + lib.optionalString (stdenv.isLinux) ''
      # Cannot be in postInstall, otherwise _multioutDocs hook in preFixup will move right back.
      moveToOutput "share/doc" "$devdoc"
    '';

    passthru = {
      updateScript = gnome.updateScript {
        packageName = "gtk";
        versionPolicy = "odd-unstable";
        attrPath = "gtk4";
      };
    };

    meta = with lib; {
      description = "A multi-platform toolkit for creating graphical user interfaces";
      longDescription = ''
        GTK is a highly usable, feature rich toolkit for creating
        graphical user interfaces which boasts cross platform
        compatibility and an easy to use API.  GTK it is written in C,
        but has bindings to many other popular programming languages
        such as C++, Python and C# among others.  GTK is licensed
        under the GNU LGPL 2.1 allowing development of both free and
        proprietary software with GTK without any license fees or
        royalties.
      '';
      homepage = "https://www.gtk.org/";
      license = licenses.lgpl2Plus;
      maintainers = teams.gnome.members ++ (with maintainers; [ raskin ]);
      platforms = platforms.all;
      changelog = "https://gitlab.gnome.org/GNOME/gtk/-/raw/${version}/NEWS";
    };
  });

  deps = with pkgs; [
    alsa-lib at-spi2-atk at-spi2-core atk cairo cups dbus expat
    fontconfig freetype gdk-pixbuf glib gtk3 gtk-4-12-5 libdrm xorg.libX11 libGL
    libxkbcommon xorg.libXScrnSaver xorg.libXcomposite xorg.libXcursor xorg.libXdamage
    xorg.libXext xorg.libXfixes xorg.libXi xorg.libXrandr xorg.libXrender xorg.libxshmfence
    xorg.libXtst libuuid mesa nspr nss pango pipewire udev wayland
    xorg.libxcb zlib snappy libkrb5
  ];
  rpath = lib.makeLibraryPath deps + ":" + lib.makeSearchPathOutput "lib" "lib64" deps;
  binpath = lib.makeBinPath deps;

  # enableFeatures = lib.optionals lib.enableVideoAcceleration [ "VaapiVideoDecoder" "VaapiVideoEncoder" ]
  #   ++ lib.optional lib.enableVulkan "Vulkan";
  enableFeatures = [];

  disableFeatures = [ "OutdatedBuildDetector" ] # disable automatic updates
    # The feature disable is needed for VAAPI to work correctly: https://github.com/brave/brave-browser/issues/20935
    # ++ lib.optionals lib.enableVideoAcceleration  [ "UseChromeOSDirectVideoDecoder" ]
    ;

  new-installPhase = with pkgs; ''
      runHook preInstall

      mkdir -p $out $out/bin

      cp -R usr/share $out
      cp -R opt/ $out/opt

      export BINARYWRAPPER=$out/opt/brave.com/brave/brave-browser

      # Fix path to bash in $BINARYWRAPPER
      substituteInPlace $BINARYWRAPPER \
          --replace /bin/bash ${stdenv.shell}

      ln -sf $BINARYWRAPPER $out/bin/brave

      for exe in $out/opt/brave.com/brave/{brave,chrome_crashpad_handler}; do
          patchelf \
              --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
              --set-rpath "${rpath}" $exe
      done

      # Fix paths
      substituteInPlace $out/share/applications/brave-browser.desktop \
          --replace /usr/bin/brave-browser-stable $out/bin/brave
      substituteInPlace $out/share/gnome-control-center/default-apps/brave-browser.xml \
          --replace /opt/brave.com $out/opt/brave.com
      substituteInPlace $out/share/menu/brave-browser.menu \
          --replace /opt/brave.com $out/opt/brave.com
      substituteInPlace $out/opt/brave.com/brave/default-app-block \
          --replace /opt/brave.com $out/opt/brave.com

      # Correct icons location
      icon_sizes=("16" "24" "32" "48" "64" "128" "256")

      for icon in ''${icon_sizes[*]}
      do
          mkdir -p $out/share/icons/hicolor/$icon\x$icon/apps
          ln -s $out/opt/brave.com/brave/product_logo_$icon.png $out/share/icons/hicolor/$icon\x$icon/apps/brave-browser.png
      done

      # Replace xdg-settings and xdg-mime
      ln -sf ${xdg-utils}/bin/xdg-settings $out/opt/brave.com/brave/xdg-settings
      ln -sf ${xdg-utils}/bin/xdg-mime $out/opt/brave.com/brave/xdg-mime

      runHook postInstall
  '';

  new-preFixup = with pkgs; with lib; ''
    # Add command line args to wrapGApp.
    gappsWrapperArgs+=(
      --prefix LD_LIBRARY_PATH : ${rpath}
      --prefix PATH : ${binpath}
      --suffix PATH : ${lib.makeBinPath [ xdg-utils coreutils ]}
      ${optionalString (enableFeatures != []) ''
      --add-flags "--enable-features=${strings.concatStringsSep "," enableFeatures}\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+,WaylandWindowDecorations}}"
      ''}
      ${optionalString (disableFeatures != []) ''
      --add-flags "--disable-features=${strings.concatStringsSep "," disableFeatures}"
      ''}
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto}}"
    )
  '';

  my-brave = pkgs.brave.overrideAttrs (final: prev : with pkgs; rec {
    buildInputs = [
      # needed for GSETTINGS_SCHEMAS_PATH
      glib gsettings-desktop-schemas gtk3 gtk-4-12-5
      # needed for XDG_ICON_DIRS
      gnome.adwaita-icon-theme
    ];
    installPhase = "${new-installPhase}";
    preFixup = "${new-preFixup}";
  });
in
{
  brave = my-brave;
}
