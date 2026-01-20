{
	lib,
	makeWrapper,
	runCommand,
	# runtime deps (depend on script)
	bash,
	jq,
}: let
	# Your external shell script.
	src = ./nvimunity.sh;
	binName = "nvimunity";
	deps = [
		bash
		jq
	];
in
	runCommand "${binName}"
	{
		nativeBuildInputs = [makeWrapper];
		meta = {
			mainProgram = "${binName}";
		};
	}
	''
		mkdir -p $out/bin
		install -m +x ${src} $out/bin/${binName}
		wrapProgram $out/bin/${binName} \
		  --prefix PATH : ${lib.makeBinPath deps}
	''
