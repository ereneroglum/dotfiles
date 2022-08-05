.PHONY: install-home install-omen install-pavilon

install-home:
	home-manager switch --flake ".#eren"

install-omen:
	sudo nixos-rebuild switch --flake '.#omen'

install-pavilon:
	sudo nixos-rebuild switch --flake '.#pavilon'

setup-unfree:
	mkdir ~/.config/nixpkgs
	printf '{ }: { allowUnfree = true; }\n' > ~/.config/nixpkgs/config.nix

