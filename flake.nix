{
  description = "Heroku Nix Deployment Example: flask";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python3.withPackages (ps: with ps; [
          flask
        ]);
      in rec {

        # the development shell
        devShells.default = python.env;

        # the python interpreter
        packages.python = python;
        packages.default = packages.run;
        packages.run = pkgs.writeShellScriptBin "run-app" ''
          ${packages.python.interpreter} -m flask run -p ''${PORT:-5000}
        '';
      }
    );
}
