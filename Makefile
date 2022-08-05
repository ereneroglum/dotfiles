export NIXPKGS_ALLOW_UNFREE = 1

.PHONY: install-home install-omen install-pavilon

install-home:
	home-manager switch --flake ".#eren"

install-omen:
	sudo nixos-rebuild switch --flake '.#omen'

install-pavilon:
	sudo nixos-rebuild switch --flake '.#pavilon'
