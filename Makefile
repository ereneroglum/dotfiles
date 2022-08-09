.PHONY: install-home install-omen install-pavilon

install-home:
	NIXPKGS_ALLOW_UNFREE=1 home-manager switch --flake ".#eren" --impure

install-omen:
	sudo nixos-rebuild switch --flake '.#omen'

install-pavilon:
	sudo nixos-rebuild switch --flake '.#pavilion'

setup-unfree:
	[ -e "~/.config/nixpkgs/config.nix" ] && printf "~/.config/nixpkgs/config.nix already exists." && exit 1
	mkdir ~/.config/nixpkgs
	printf '{ allowUnfree = true; }\n' > ~/.config/nixpkgs/config.nix

