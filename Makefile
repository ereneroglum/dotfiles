.PHONY: install-home install-omen install-pavilion

install-home:
	NIXPKGS_ALLOW_UNFREE=1 home-manager switch --flake ".#eren" --impure

install-omen:
	sudo nixos-rebuild switch --flake '.#omen'

install-pavilion:
	sudo nixos-rebuild switch --flake '.#pavilion'

setup-channels:
	sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable
	sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

update-channels:
	sudo nix-channel --update

setup-home-manager:
	nix-shell '<home-manager>' -A install

