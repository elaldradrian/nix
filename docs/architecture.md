# Architecture

## Overview

This flake manages 8 machines using a layered, modular architecture built on `flake-parts`. The design follows a **core/opt** pattern at every level: core modules are always applied, while optional features are toggled per-host.

## Directory Structure

```
flake.nix                    # Root: inputs, outputs, overlays, devShell
hosts/                       # Host-specific configurations
  default.nix                # mkHost() factory for NixOS and Darwin
  <hostname>/
    default.nix              # Host overrides and feature toggles
    hardware-configuration.nix  # Hardware-specific settings
modules/
  nixos/
    core/                    # Always-applied NixOS modules
    opt/                     # Optional NixOS features
  darwin/
    core/                    # Always-applied macOS modules
    opt/                     # Optional macOS features
  home/
    core/                    # Always-applied Home Manager modules
    opt/                     # Optional Home Manager features
packages/
  nvim/                      # Neovim via nixvim
home/
  default.nix                # hostname -> profile list mapping
  profiles/
    <hostname>.nix           # Per-host Home Manager feature list
secrets/
  <hostname>/secrets.json    # SOPS-encrypted per-host secrets
  k3s/secrets.json           # Shared k3s cluster token
```

## Module Layers

### Core Modules (Always Applied)

**NixOS core** (`modules/nixos/core/`):
- `boot.nix` — systemd-boot, EFI
- `i18n.nix` — en_DK locale, da_DK regional format
- `network.nix` — NetworkManager
- `nix.nix` — Flakes, trusted users, stable overlay
- `options.nix` — `core.features.*` definitions (proxmox, ssh, vm-guest)
- `programs.nix` — Fish shell
- `security.nix` — PAM limits, polkit
- `sops.nix` — sops-nix per-host integration
- `ssh.nix` — OpenSSH server (conditional on `core.features.ssh.enable`)
- `system.nix` — stateVersion 24.11
- `time.nix` — Europe/Copenhagen timezone
- `user.nix` — User "rune", groups, SSH keys
- `vm-guest.nix` — QEMU guest tools (conditional)
- `proxmox.nix` — Proxmox VE (conditional overlay)

**Darwin core** (`modules/darwin/core/`):
- `nix.nix` — Flakes, linux-builder, IOG cache
- `options.nix` — `core.features.vpn`
- `programs.nix` — Fish shell
- `security.nix` — TouchID for sudo
- `system.nix` — Primary user, keyboard, dock/finder defaults, dark mode
- `user.nix` — User uid 501, fish shell

**Home core** (`modules/home/core/`):
- `home.nix` — Username, stateVersion 25.05
- `home-manager.nix` — Self-managing home-manager
- `nixpkgs.nix` — Package configuration
- `sops.nix` — Per-host secrets

### Optional Modules (Feature-Toggled)

**NixOS opt** (`modules/nixos/opt/`):
- `packages.nix` — git, p7zip, parted + ceph tools (if proxmox)
- `font.nix` — Fira Code + Nerd Fonts
- `services.nix` — greetd + sway (if desktop)
- `modules/1password.nix` — 1Password CLI + GUI
- `modules/backup-vault.nix` — SSHFS mount to your-storagebox.de
- `modules/ceph.nix` — Ceph client at /mnt/backup/cephfs
- `modules/docker.nix` — Docker daemon
- `modules/k3s.nix` — k3s server v1.32 (token from SOPS)
- `modules/light.nix` — ACPI backlight control
- `modules/llama-cpp.nix` — llama.cpp systemd service
- `modules/prometheus.nix` — Prometheus scraping llama-cpp metrics
- `modules/steam.nix` — Steam + Proton-GE
- `modules/vpn.nix` — Tailscale

**Darwin opt** (`modules/darwin/opt/`):
- `aerospace.nix` — AeroSpace tiling WM (i3-like bindings)
- `font.nix` — Fira Code
- `homebrew.nix` — 1Password, Teams, Outlook, Chrome, Slack, etc.
- `packages.nix` — git, p7zip, Xcode 26

**Home opt** (`modules/home/opt/`):
- `packages.nix` — Conditional: nvim, btop, gh, k9s, kubectl, node, python, etc.
- `session.nix` — EDITOR=nvim, SOPS_AGE_KEY_FILE, sessionPath
- `fish.nix` — Fish with vi keybindings, fzf, tmux session renaming
- `tmux.nix` — tmux with vim-aware navigation, plugins
- `direnv.nix` — direnv + nix-direnv + instant mode
- `zoxide.nix` — zoxide with fish integration
- `services.nix` — gnome-keyring (if desktop)
- `programs/` — Per-program configs: cursor, docker, git, kitty, llama-cpp, opencode, ssh, sway, vpn, waybar

## Host Factory Pattern

The `hosts/default.nix` file defines `mkHost()` for both NixOS and Darwin:

```nix
mkHost {
  hostname = "myhost";       # Directory under hosts/
  user = "rune";             # Home Manager user (null = no HM)
  extraModules ? [ ];        # Additional modules (used for proxmox)
}
```

The factory:
1. Loads core + opt modules
2. Imports host-specific `./<hostname>/default.nix`
3. Injects `specialArgs`: `inputs`, `self`, `hostname`, `user`, `homeDir`
4. Attaches Home Manager with per-host profile imports

## Home Manager Profiles

`home/default.nix` maps each hostname to a list of feature-enabling modules from `home/profiles/<hostname>.nix`. Each profile is a simple Nix expression that sets `opt.features.*.enable = true`.

## Secrets Management

SOPS encrypts secrets with age. The `.sops.yaml` defines:
- Per-host age public keys
- Path-based key groups (e.g., k3s secrets shared across all k3s + personal machines)
- Per-host `secrets/<hostname>/secrets.json` files
- SOPS templates for generating config from secrets

Access secrets in modules via `config.sops-secrets."<name>"`.

## Flake Inputs

| Input | Branch/Ref | Follows nixpkgs? |
|-------|------------|-----------------|
| `nixpkgs` | nixpkgs-unstable | — |
| `nixpkgs-stable` | nixos-25.11 | — |
| `nix-darwin` | main | yes |
| `nixvim` | main | yes |
| `hm` | master | yes |
| `flake-parts` | main | no |
| `pre-commit-hooks` | master | yes |
| `sops-nix` | main | yes |
| `direnv-instant` | main | yes |
| `proxmox-nixos` | feature/sanctuary-cluster | no |

The `pkgs.stable` overlay provides `nixpkgs-stable` as `pkgs.stable` for packages requiring stability (e.g., ceph-client).

## Pre-commit Hooks

Defined in `pre-commit-hooks.nix`, auto-generated to `.pre-commit-config.yaml`:
- `deadnix` — Detect dead Nix code
- `flake-checker` — Validate flake.nix syntax
- `nixfmt` — Format Nix files
