# Jarvis Homelab

NixOS + Docker hybrid homelab. Declarative, reproducible, Tailscale-connected.

## Quick Start

```bash
# On the NixOS box after minimal install:
git clone <this-repo> ~/homelab
cd ~/homelab
./scripts/bootstrap.sh

# Connect to tailnet
sudo tailscale up --auth-key=tskey-auth-XXXX --advertise-tags=tag:homelab
```

## Structure

```
flake.nix                 System entry point
machines/jarvis/          Hardware-specific config
modules/
  common.nix              Users, packages, SSH, sops
  tailscale.nix           VPN mesh
  ollama.nix              AI inference (CPU/GPU)
  docker.nix              Docker + auto-start compose
  home-assistant.nix      HA (disabled, uncomment when ready)
docker/compose.yml        Containerized services
secrets/                  sops-nix encrypted secrets
scripts/
  bootstrap.sh            First-time setup
  backup.sh               Volume + data backup
Makefile                  Common operations
```

## Usage

```bash
make apply        # nixos-rebuild switch
make test         # nixos-rebuild test (no switch)
make update       # nix flake update
make diff         # show what would change
make docker-up    # start containers
make gc           # garbage collect old generations
```

## From Your Mac

```bash
jv                # SSH into jarvis (tmux)
jvs               # quick status check
jva               # apply NixOS config remotely
jvl               # follow system logs
jvl ollama        # follow specific service
jvd               # docker container status
```

Requires the `homelab.zsh` functions from your dotfiles.

## Secrets

Uses [sops-nix](https://github.com/Mic92/sops-nix) with age encryption.

```bash
# Edit secrets (auto-encrypts on save)
sops secrets/secrets.yaml

# Key location
~/.config/sops/age/keys.txt
```

## Adding a Service

**Native (NixOS module):** Create `modules/my-service.nix`, add to `flake.nix` modules list.

**Docker:** Add to `docker/compose.yml`, run `make docker-up`.
