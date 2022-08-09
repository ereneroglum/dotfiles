.PHONY: install-home install-omen install-pavilion

install-home:
	NIXPKGS_ALLOW_UNFREE=1 home-manager switch --flake ".#eren" --impure

install-omen:
	sudo nixos-rebuild switch --flake '.#omen'

install-pavilion:
	sudo nixos-rebuild switch --flake '.#pavilion'

