{
	lib,
	stdenv,
	fetchurl,
	makeBinaryWrapper,
	copyDesktopItems,
	makeDesktopItem,
	desktopToDarwinBundle,
	unzip,
	imagemagick,
	jre,
}:
stdenv.mkDerivation (
	finalAttrs: {
		pname = "mars-mips";
		version = "custom";

		src =
			fetchurl {
				url = "https://lecturer-russ.appspot.com/classes/cs252/fall25/Mars4.5la.jar";
				hash = "sha256-vSdL00HEIkMvX7kyd15G/OyHQNFWaMuk05iA89pHL+0=";
			};

		dontUnpack = true;

		nativeBuildInputs =
			[
				makeBinaryWrapper
				copyDesktopItems
				unzip
				imagemagick
			]
			++ lib.optionals stdenv.hostPlatform.isDarwin [
				desktopToDarwinBundle
			];

		desktopItems = [
			(makeDesktopItem {
					name = "mars";
					desktopName = "MARS";
					exec = "Mars";
					icon = "mars";
					comment = finalAttrs.meta.description;
					categories = [
						"Development"
						"IDE"
					];
				})
		];

		installPhase = ''
			runHook preInstall

			export JAR=$out/share/java/mars/Mars.jar
			install -Dm444 $src $JAR
			makeWrapper ${jre}/bin/java $out/bin/Mars \
			  --add-flags "-jar $JAR"

			unzip $src images/MarsThumbnail.gif
			for size in 16 24 32 48 64 128 256 512
			do
			  mkdir -p $out/share/icons/hicolor/"$size"x"$size"/apps
			  convert -resize "$size"x"$size" images/MarsThumbnail.gif $out/share/icons/hicolor/"$size"x"$size"/apps/mars.png
			done

			runHook postInstall
		'';

		meta = {
			description = "An IDE for programming in MIPS assembly language intended for educational-level use";
			mainProgram = "Mars";
			sourceProvenance = with lib.sourceTypes; [binaryBytecode];
		};
	}
)
