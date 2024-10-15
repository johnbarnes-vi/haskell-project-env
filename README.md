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

Note: direnv and nix-direnv will be automatically set up by the .envrc file if not already present.

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/create-haskell-project.git
   cd create-haskell-project
   ```

2. Make the script executable:
   ```bash
   chmod +x create-haskell-project
   ```

3. Optionally, add the directory containing the script to your PATH.

4. Ensure you have direnv hooks set up in your shell. If not, add the following to your shell configuration file (e.g., .bashrc, .zshrc):
   ```bash
   eval "$(direnv hook bash)"  # or zsh, fish, etc.
   ```

## Usage

1. Navigate to the directory where you want to create your Haskell projects:
   ```bash
   cd ~/haskell-projects
   ```

2. Run the create-haskell-project script:
   ```bash
   ./path/to/create-haskell-project
   ```

3. Enter the name of your new Haskell project when prompted.

4. The script will:
   - Create a new directory for your project
   - Initialize a Cabal project
   - Set up a Nix flake for the project
   - Initialize a Git repository
   - Create a .envrc file for direnv

5. To enter the development environment, run:
   ```bash
   cd your-project-name && direnv allow
   ```
   This will automatically set up nix-direnv if it's not already installed.

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

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- The Nix community for providing excellent tools for reproducible development environments
- The Haskell community for their ongoing work on Cabal and GHC