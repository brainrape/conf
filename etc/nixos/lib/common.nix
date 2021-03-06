{ config, pkgs, ... }:

{
  nix.useSandbox = true;

  nixpkgs.config.allowUnfree = true;

  boot.supportedFilesystems = [ "ext" "exfat" "vfat" "ntfs" "xfs" ];

  networking.firewall.enable = false;

  security.rtkit.enable = true;

  powerManagement.enable = true;

  console = {
    earlySetup = true;
    font = "ter-i32n";
    packages = [ pkgs.terminus_font ];
  };

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
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFZOC3FgP/8TUK62obAW/uDENhdXkLGAjickSF53zncg ssdd@eki" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    tmux git direnv file toilet gparted rfkill powertop
    iputils iw wirelesstools bind nmap mtr pinentry-curses
  ];

  programs.zsh.enable = true;
  programs.mtr.enable = true;
  programs.tmux.enable = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "19.09";
}
