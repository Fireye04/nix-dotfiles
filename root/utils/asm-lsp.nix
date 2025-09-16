{
	lib,
	stdenv,
	rustPlatform,
	fetchFromGitHub,
	pkg-config,
	openssl,
}: let
	pname = "asm-lsp";
	version = "9df3f5178531c8f89114098ba52f1237bbfa6dd5";
in
	rustPlatform.buildRustPackage {
		inherit pname version;

		src =
			fetchFromGitHub {
				owner = "bergercookie";
				repo = "asm-lsp";
				rev = "${version}";
				hash = "sha256-PWlxqU+3bu/BGq5JFqgm3cYhasafOnMjxQ8fhWyGn8M=";
			};

		nativeBuildInputs = [pkg-config];

		buildInputs = lib.optionals (!stdenv.hostPlatform.isDarwin) [openssl];

		cargoHash = "";

		# tests expect ~/.cache/asm-lsp to be writable
		preCheck = ''
			export HOME=$(mktemp -d)
		'';

		meta = {
			description = "Language server for NASM/GAS/GO Assembly";
			homepage = "https://github.com/bergercookie/asm-lsp";
			license = lib.licenses.bsd2;
			maintainers = with lib.maintainers; [
				NotAShelf
				CaiqueFigueiredo
			];
			mainProgram = "asm-lsp";
			platforms = lib.platforms.unix;
		};
	}
