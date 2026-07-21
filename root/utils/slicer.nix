{
	stdenv,
	lib,
	fetchFromGitHub,
	autoPatchelfHook,
	makeDesktopItem,
	glib,
	fetchzip,
	pulseaudio,
	xorg,
	zlib,
	fontconfig,
	libxkbcommon,
	libGL,
	libGLU,
	freetype,
	cups,
	unixODBC,
	libxcrypt-legacy,
	alsa-lib,
	postgresql,
	nss,
	nspr,
	hwloc,
	fetchurl,
}: let
	pname = "Slicer3D";
	version = "5.10.0";

	hwloc_old =
		hwloc.overrideAttrs (
			old: let
				hwloc_version = "1.11.13";
			in {
				version = hwloc_version;

				src =
					fetchFromGitHub {
						owner = "open-mpi";
						repo = "hwloc";
						tag = "hwloc-${hwloc_version}";
						hash = "sha256-dR/N3yMGT97rZgj+p3uXZKB4hxv15lJmKWXXSPa1Nlw=";
					};

				outputs = [
					"out"
					"lib"
					"dev"
					"man"
				];
			}
		);

	desktopItem =
		makeDesktopItem {
			name = "Slicer3D";
			exec = "../Slicer";
			desktopName = "Slicer 3D";
			genericName = "Multi-platform, free open source software for visualization and image computing. ";
			categories = [
				"Graphics"
				"MedicalSoftware"
				"Science"
			];
		};
in
	stdenv.mkDerivation {
		inherit pname version;
		src =
			fetchzip {
				name = "Slicer-${version}-linux-amd64.tar.gz";
				url = "http://download.slicer.org/download?os=linux&stability=release&version=${version}";
				hash = "sha256-TsPO/fqeNl3d0/PWrfIgRdcBRY0AjRhzdbEMo4SDfAE=";
				extension = "tar.gz";
			};

		nativeBuildInputs = [
			autoPatchelfHook
		];

		buildInputs =
			[
				freetype
				zlib
				libGL
				libGLU
				fontconfig
				alsa-lib
				postgresql
				libxkbcommon
				glib
				pulseaudio
				cups
				unixODBC
				libxcrypt-legacy
				nss
				nspr
				hwloc
				hwloc_old
			]
			++ (with xorg; [
					libSM
					libICE
					libXrender
					libXext
					libX11
					xkbutils
					xcbutil
					xcbutilwm
					xcbutilimage
					xcbutilrenderutil
					xcbutilkeysyms
					libXdamage
					libXfixes
					libXrandr
					libXcursor
					libXtst
					libXcomposite
				]);

		installPhase = ''
			runHook preInstall
			mkdir $out
			cp -r . $out
			mkdir $out/share/applications/
			cp ${desktopItem}/share/applications/* $out/share/applications/
			runHook postInstall
		'';

		desktopItems = [
			desktopItem
		];

		meta = {
			description = "Multi-platform, free open source software for visualization and image computing";
			sourceProvenance = [lib.sourceTypes.binaryNativeCode];
			mainProgram = "Slicer";
			homepage = "https://www.slicer.org";
			license = lib.licenses.free; # Licence is a BSD style license: https://github.com/Slicer/Slicer/blob/5.6/License.txt
			changelog = "https://discourse.slicer.org/t/slicer-${lib.versions.major version}-${lib.versions.minor version}-summary-highlights-and-changelog";
			platforms = ["x86_64-linux"];
			maintainers = with lib.maintainers; [purepani];
		};
	}
