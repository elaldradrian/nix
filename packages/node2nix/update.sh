#!/usr/bin/env bash
cd "$(dirname "$0")"
node2nix -i packages.json --include-peer-dependencies
