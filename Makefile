.PHONY: help install-home install-omen install-pavilion

define HELPMESSAGE
Usage: make [flags]

Possible flags:

install-home: Setup home configuration. (requires home-manager and channels)
install-omen: Sets up nixos configuration for omen. (requires channels)
install-pavilion: Sets up nixos configuration for pavilion. (requires channels)
setup-channels: Sets up channels for home-manager and nixos.
update-channels: Update installed channels.
setup-home-manager: Installs home-manager.

NOTE:

If you want to disable flakes set environment variable DISABLE_FLAKE. Possible usage:

DISABLE_FLAKE=1 make [flags]

endef

export HELPMESSAGE
help:
	@printf "$$HELPMESSAGE"

export NIXPKGS_ALLOW_UNFREE=1
install-home:
ifdef DISABLE_FLAKE
	home-manager switch -f "./home-configs/home.nix" --impure
else
	home-manager switch --flake ".#eren" --impure
endif

install-omen:
ifdef DISABLE_FLAKE
	sudo nixos-rebuild switch -I nixos-config="./machine-configs/omen.nix"
else
	sudo nixos-rebuild switch --flake '.#omen'
endif

install-pavilion:
ifdef DISABLE_FLAKE
	sudo nixos-rebuild switch -I nixos-config="./machine-configs/pavilon.nix"
else
	sudo nixos-rebuild switch --flake '.#pavilion'
endif

setup-channels:
	sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable
	sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

update-channels:
	sudo nix-channel --update

setup-home-manager:
	nix-shell '<home-manager>' -A install

