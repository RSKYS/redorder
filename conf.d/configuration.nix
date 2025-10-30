{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  users.defaultUserShell = pkgs.bash;

  environment.etc = {
    profile = {
      text = ''
        fastfetch
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    bash
    vim
    wget
    fastfetch
    git
    htop
    sudo
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.grub = {
    enable = true;
    version = 2;
    devices = [ "/dev/sda" ];
  };

  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "RedAster";
    domain = "RedAster.home";
    networkmanager.enable = false;
    useDHCP = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8" ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.openssh = {
    enable = true;
    settings = {
      Port = "22";
      PermitRootLogin = "yes";
      PasswordAuthentication = "yes";
      PubkeyAuthentication = "yes";
    };
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

#   system.autoUpgrade = {
#     enable = true;
#     schedule = "weekly";
#   };

#   services.journald.extraConfig = {
#     SystemMaxUse = "500M";
#   };

#   time.timeZone = "";

  system.stateVersion = lib.trivial.release; 
}
