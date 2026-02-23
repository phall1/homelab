HOST ?= jarvis

.PHONY: apply test bootstrap update diff check gc docker-up docker-down

apply:
	sudo nixos-rebuild switch --flake .#$(HOST)

test:
	sudo nixos-rebuild test --flake .#$(HOST)

bootstrap: apply
	@echo ""
	@echo "Next: run 'sudo tailscale up --auth-key=tskey-auth-XXXX --advertise-tags=tag:homelab'"
	@echo "Then: cd ~/dotfiles && ./install.sh"

update:
	nix flake update
	@echo "Lockfile updated. Review with: make diff"
	@echo "Apply with: make apply"

diff:
	nixos-rebuild build --flake .#$(HOST)
	nvd diff /run/current-system ./result

check:
	nix flake check

gc:
	sudo nix-collect-garbage -d
	sudo nix-store --optimise

docker-up:
	docker compose -f docker/compose.yml up -d --remove-orphans

docker-down:
	docker compose -f docker/compose.yml down
