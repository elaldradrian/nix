# AGENTS.md

Instructions for AI agents working on this Nix flake dotfiles repository.

## Project Summary

Personal Nix Flake managing 8 machines (NixOS + macOS) with modular core/opt architecture. Uses flake-parts, home-manager, sops-nix, and nixvim.

## Key Conventions

### Documentation
- Keep `docs/architecture.md` and `README.md` in sync with code changes
- When modifying packages, versions, or features, update the corresponding documentation entries

### File Organization
- `default.nix` files aggregate imports from sibling files
- Files named after the feature they configure (e.g., `ssh.nix`, `docker.nix`)
- `core/` = always applied, `opt/` = feature-toggled
- Host directories use hostname as directory name

### Nix Patterns
- Use `lib.mkIf` for conditional configuration blocks
- Use `lib.mkMerge` for merging multiple config blocks
- Use `mkEnableOption` and `mkOption` for custom module options
- Options namespace: `core.*` for system-level, `opt.*` for host-level
- `specialArgs` passes `inputs`, `self`, `hostname`, `user`, `homeDir` to modules

### Adding a New Feature
1. Define option in `modules/<platform>/opt/options.nix` (e.g., `opt.features.myfeature.enable`)
2. Create `modules/<platform>/opt/modules/myfeature.nix` with `lib.mkIf cfg.opt.features.myfeature.enable`
3. Import in `modules/<platform>/opt/default.nix`
4. Enable in host's `hosts/<hostname>/default.nix`

### Adding a New Home Feature
1. Define option in `modules/home/opt/options.nix`
2. Create module in `modules/home/opt/` or `modules/home/opt/programs/`
3. Import in `modules/home/opt/default.nix`
4. Add to `home/profiles/<hostname>.nix`

### Adding a New Host
1. Create `hosts/<hostname>/` with `default.nix` and `hardware-configuration.nix`
2. Register in `hosts/default.nix` via `mkHost { hostname = "..."; user = "..."; }`
3. Add age key to `.sops.yaml`
4. Create `secrets/<hostname>/secrets.json`
5. Create `home/profiles/<hostname>.nix`

### Secrets
- Encrypted with SOPS + age
- Keys at `~/.config/sops/age/keys.txt`
- Access via `config.sops-secrets."<name>"`
- Use SOPS templates for generating config files from secrets

### Neovim
- Configured via nixvim in `packages/nvim/`
- Modular: ai/, completion/, lsp/, mini/, treesitter/, ui/, util/
- Run with `nix run .#nvim`

## Commands

```bash
# Enter dev shell
direnv allow

# Deploy NixOS host
nixos-rebuild switch --flake .#<hostname>

# Deploy macOS host
darwin-rebuild switch --flake .#<hostname>

# Run Neovim
nix run .#nvim

# Format all Nix files
nixfmt --write .

# Check flake
nix flake check

# Update inputs
nix flake update

# Edit secrets
sops secrets/<hostname>/secrets.json
```

## Flake Inputs
- `nixpkgs` (unstable) — primary packages
- `nixpkgs-stable` (nixos-25.11) — as `pkgs.stable` overlay
- `nix-darwin`, `nixvim`, `hm`, `flake-parts`, `sops-nix`, `proxmox-nixos`, `direnv-instant`, `pre-commit-hooks`

## Systems
aarch64-linux, x86_64-linux, aarch64-darwin, x86_64-darwin
