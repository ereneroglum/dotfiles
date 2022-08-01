{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        gfxmodeEfi = "1920x1080";
      };
    };
    tmpOnTmpfs = true;
  };

  networking = {
    hostName = "nixos";
    useDHCP = false;
    enableIPv6 = false;
    interfaces.enp5s0.ipv4.addresses = [{
      address = "192.168.1.3";
      prefixLength = 24;
    }];
    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    firewall = {
      allowedUDPPorts = [ 51000 ];
      allowedTCPPorts = [ 25565 51000 ];
    };
  };

  time.timeZone = "Europe/Istanbul";

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      layout = "tr";
      videoDrivers = [ "nvidia" ];
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;
    nvidia.modesetting.enable = true;
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    xwayland.enable = true;
  };

  users.users.eren = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment = {
    enableDebugInfo = true;
    systemPackages = with pkgs; [];
  };

  documentation.dev.enable = true;

  system.stateVersion = "22.11";
}

