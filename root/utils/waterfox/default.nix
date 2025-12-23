{
	stdenv,
	fetchurl,
	makeWrapper,
	makeDesktopItem,
	autoPatchelfHook,
	lib,
	wrapGAppsHook3,
	alsa-lib,
	at-spi2-atk,
	at-spi2-core,
	atk,
	cairo,
	cups,
	dbus-glib,
	libnotify,
	libdrm,
	libxkbcommon,
	mesa,
	nspr,
	nss,
	pango,
	systemd,
	libpulseaudio,
	gdk-pixbuf,
	gtk3,
	unzip,
	libX11,
	libXScrnSaver,
	libXcomposite,
	libXcursor,
	libXdamage,
	libXext,
	libXfixes,
	libXi,
	libXrandr,
	libXrender,
	libXtst,
	libxcb,
	writeText,
	patchelf,
	libGL,
	ffmpeg,
	glib,
	pciutils,
}:
stdenv.mkDerivation rec {
	pname = "waterfox";
	version = "6.6.7";
	src =
		fetchurl {
			url = "https://cdn.waterfox.com/waterfox/releases/${version}/Linux_x86_64/waterfox-${version}.tar.bz2";
			hash = "sha256-/R2rQkYPJ8boC/hHK39UuIkKyAHjaW+t7s5aaWZYTTI=";
		};

	dontUnpack = true;
	nativeBuildInputs = [
		makeWrapper
		autoPatchelfHook
	];
	buildInputs = [
		dbus-glib
		libnotify
		libdrm
		libxkbcommon
		libX11
		libXScrnSaver
		libXcomposite
		libXcursor
		libXdamage
		libXext
		libXfixes
		libXi
		libXrandr
		libXrender
		libXtst
		libxcb
		libGL
		ffmpeg
		glib
	];
	installPhase = ''
		mkdir -p $out/bin
		mkdir -p $out/src
		      tar xf ${src} -C $out/src
		      makeWrapper $out/src/waterfox/waterfox $out/bin/waterfox
	'';
	# desktopItems = [
	# 	(makeDesktopItem {
	# 			name = "waterfox";
	# 			desktopName = "waterfox";
	# 			exec = "";
	# 		})
	# ];
}
