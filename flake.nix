{
	description = "Generate help reference texts";

	inputs = {
		flake-parts = { type="github"; owner="hercules-ci"; repo="flake-parts"; };
		nixpkgs = { type="github"; owner="NixOS"; repo="nixpkgs"; ref="nixpkgs-unstable"; };
	};

	outputs = inputs@{ flake-parts, ... }:
		flake-parts.lib.mkFlake { inherit inputs; } {
			systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
			perSystem = { self', lib, pkgs, system, ... }: {
				packages = let pkgName = "fish-helpText"; in {
					default = self'.packages.${pkgName};
					${pkgName} = pkgs.stdenvNoCC.mkDerivation {
						name = pkgName;
						inherit system;

						src = ./.;
						installPhase = ''${lib.meta.getExe pkgs.fish} --no-config --private -- ${./install.fish} ${./.}'';

						meta = {
							description = "Fish plugin: generate elegant help reference texts";
							homepage = "https://github.com/Drazape/fish-helpText";
							license = lib.licenses.mit;
							platforms = lib.platforms.linux;
						};
					};
				};
			};
		};
}
