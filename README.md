# create-haskell-project

A Nix-based tool for creating Haskell projects that balances Nix's reproducibility with Haskell's ecosystem conventions. It uses Nix for consistent project initialization and development tools, while allowing Cabal to manage core Haskell toolchain and dependencies for maximum flexibility.

## Features

- Nix-based project initialization for consistency across different environments
- Integrated with direnv for automatic environment activation
- Uses Cabal for Haskell-specific dependency management
- Includes Haskell Language Server for enhanced development experience
- Supports multiple systems (Linux and macOS, both x86_64 and aarch64)
- Creates individual Git repositories for each project

## Prerequisites

- Nix package manager
- Git

Note: nix-direnv will be automatically set up by the .envrc file if not already present.

## Installation and Setup

1. Ensure you have Nix installed on your system.
2. Clone this repository:

   ```bash
   git clone https://github.com/johnbarnes-vi/haskell-project-env.git
   cd haskell-project-env
   ```
3. Allow direnv to load the environment:

   ```bash
   direnv allow
   ```

   This step will set up the necessary environment, including making the `create-haskell-project` script available.

## Usage

1. From within the `create-haskell-project` directory, run:

   ```bash
   create-haskell-project
   ```
2. Follow the prompts to name your project and answer the questions from `cabal init`.
3. Once complete, you can cd into your new project directory:

   ```bash
   cd your-project-name
   ```
4. Allow direnv to load the project-specific environment:

   ```bash
   direnv allow
   ```

Your new Haskell project is now set up and ready for development!

## Project Structure

Each created project will have the following structure:

```
your-project-name/
├── .envrc
├── .gitignore
├── app/
│   └── Main.hs
├── CHANGELOG.md
├── flake.nix
├── LICENSE
└── your-project-name.cabal
```

## Customization

You can customize the project template by modifying the `create-haskell-project` script. Common customizations include:

- Changing the default license
- Adding more default dependencies
- Modifying the flake.nix to include additional development tools

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Acknowledgments

- The Nix community for providing excellent tools for reproducible development environments
- The Haskell community for their ongoing work on Cabal and GHC
