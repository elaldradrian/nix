# Rune's Nix Dotfiles

Personal Nix Flake-based dotfiles and infrastructure management for 8 machines across NixOS and macOS.

## Managed Systems

| Host | Platform | Role |
|------|----------|------|
| `rune-mac` | macOS (aarch64-darwin) | Personal Mac |
| `rune-workstation` | NixOS (x86_64-linux) | AMD desktop, AI workstation |
| `rune-laptop` | NixOS | Laptop |
| `k3s-1` | NixOS (aarch64-linux) | k3s cluster init node |
| `k3s-2` | NixOS | k3s server node |
| `k3s-3` | NixOS | k3s server node |
| `pve-1` | NixOS (aarch64-linux) | Proxmox + Ceph node 1 |
| `pve-2` | NixOS | Proxmox + Ceph node 2 |
| `pve-3` | NixOS | Proxmox + Ceph node 3 |

## Quick Start

```bash
# Enter dev shell (requires direnv)
direnv allow

# Deploy NixOS host
nixos-rebuild switch --flake .#<hostname>

# Deploy macOS host
darwin-rebuild switch --flake .#<hostname>

# Run Neovim
nix run .#nvim

# Format Nix files
nixfmt --write .
```

## Architecture

A modular **core/opt** pattern with feature toggles per host:

- **`modules/nixos/core/`** — Always-applied NixOS modules (boot, network, user, ssh, sops, etc.)
- **`modules/nixos/opt/`** — Optional features toggled via `opt.features.*.enable`
- **`modules/darwin/core/`** + **`modules/darwin/opt/`** — Same pattern for macOS
- **`modules/home/core/`** + **`modules/home/opt/`** — Shared Home Manager config across all hosts

For detailed architecture, see [docs/architecture.md](docs/architecture.md).

## Inputs

| Input | Purpose |
|-------|---------|
| `nixpkgs` (unstable) | Primary package source |
| `nixpkgs-stable` (nixos-25.11) | Stable packages as `pkgs.stable` |
| `nix-darwin` | macOS system management |
| `nixvim` | Declarative Neovim package |
| `hm` (home-manager) | User environment management |
| `flake-parts` | Modular flake framework |
| `sops-nix` | Age-encrypted secrets |
| `proxmox-nixos` | Proxmox VE + Ceph modules |
| `direnv-instant` | Zero-latency direnv |
| `pre-commit-hooks` | Git hooks (deadnix, flake-checker, nixfmt) |

## Feature Toggles

### NixOS (`opt.features`)
- `backup-vault` — SSHFS mount to backup server
- `ceph` — Ceph client filesystem at `/mnt/backup/cephfs`
- `desktop` — Sway WM + greetd display manager
- `docker` — Docker daemon
- `k3s` — k3s Kubernetes (with `clusterInit` and `serverAddr`)
- `vpn` — Tailscale
- `llama-cpp` — Local LLM server via systemd
- `prometheus` — Metrics scraping for llama-cpp

### Home Manager (`opt.features`)
- `desktop` — gnome-keyring, desktop tools
- `devUtils` — Development packages (node, python, kubectl, gh, etc.)
- `docker` — Docker CLI config
- `llama-cpp` — LLM launchd agent (macOS)
- `vpn` — Trayscale GUI
- `work-machine` — Separate work git identity

### Home Manager (`opt.programs`)
- `colima` — Colima container runtime (macOS)
- `1password` — 1Password CLI + SSH agent integration

## Secrets

Encrypted with SOPS + age. Keys stored at `~/.config/sops/age/keys.txt`.

```bash
# Edit a host's secrets
sops secrets/<hostname>/secrets.json

# Add a new age key to .sops.yaml
age-keygen
```

## Neovim

Custom Neovim package via nixvim with 20+ plugins, LSP for 15+ languages, blink-cmp completion, treesitter, and AI integration with opencode.nvim.

```bash
nix run .#nvim
```

See `packages/nvim/` for configuration.
