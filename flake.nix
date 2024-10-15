{
  description = "Haskell project creation environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        create-project = pkgs.writeScriptBin "create-haskell-project" ''
          #!${pkgs.bash}/bin/bash
          set -e

          echo "Enter the name of your new Haskell project:"
          read project_name

          if [ -z "$project_name" ]; then
            echo "Error: Project name cannot be empty."
            exit 1
          fi

          if [ -d "$project_name" ]; then
            echo "Error: A directory with this name already exists."
            exit 1
          fi

          mkdir "$project_name"
          cd "$project_name"

          # Initialize Cabal project
          ${pkgs.nix}/bin/nix-shell -p "haskellPackages.ghcWithPackages (pkgs: with pkgs; [ cabal-install ])" --run "cabal init --interactive --minimal"

          # Create .envrc
          echo 'if ! has nix_direnv_version || ! nix_direnv_version 2.3.0; then
            source_url "https://raw.githubusercontent.com/nix-community/nix-direnv/2.3.0/direnvrc" "sha256-DzlYZ33mWF/Gs8DDeyjr8mnVmQGx7ASYqA5WlxwvBG4="
          fi
          use flake' > .envrc

        # Create flake.nix
        cat > flake.nix << EOL
        {
        description = "A simple Haskell development environment";

        inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        outputs = { self, nixpkgs }:
            let
            supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
            forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
            nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
            in
            {
            devShells = forAllSystems (system:
                let
                pkgs = nixpkgsFor.${system};
                in
                {
                default = pkgs.haskellPackages.developPackage {
                    root = ./.;
                    modifier = drv:
                    pkgs.haskell.lib.addBuildTools drv (with pkgs.haskellPackages;
                        [
                        haskell-language-server
                        ]);
                };
                });
            };
        }
        EOL

        # Initialize Git repository
        echo ".direnv/" > .gitignore
        git init
        git add .
        git commit -m "Initial commit"

        echo "Project $project_name has been created, initialized, and Git repository set up."
        echo "To enter the development environment, run:"
        echo "cd $project_name && direnv allow"
        '';
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [ create-project ];
        };
      }
    );
}