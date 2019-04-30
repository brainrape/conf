{ config, pkgs, ... }:

{
  nix.useSandbox = true;

  nixpkgs.config.allowUnfree = true;

  boot.earlyVconsoleSetup = true;
  boot.supportedFilesystems = [ "ext" "exfat" "vfat" "ntfs" "xfs" ];

  networking.firewall.enable = false;

  security.rtkit.enable = true;

  powerManagement.enable = true;

  programs.zsh.enable = true;

  services.avahi = {
    enable = true;
    nssmdns = true;
    ipv6 = true;
    publish = {
      enable = true;
      domain = true;
      workstation = true;
      hinfo = true;
      addresses = true;
      userServices = true;
    };
  };

  services.openssh = {
    enable = true;
    forwardX11 = true;
  };

  users.users.ssdd = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "vboxusers" "docker" "dialout" "audio" "video" "storage" "adbusers" "sway"];
    shell = pkgs.zsh;
  };

  users.users.guest = {
    isNormalUser = true;
    uid = 1111;
    extraGroups = [ "networkmanager" "audio" ];
    password = "guest";
  };

  environment.systemPackages = with pkgs; [
    git direnv file toilet gparted rfkill powertop
    iputils iw wirelesstools bind nmap
  ];

  programs.mtr.enable = true;
  programs.tmux.enable = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "18.09";
}
