{
  allowUnfree = true;

  firefox = {
    enableGnomeExtensions = false;
    enableAdobeFlash = true;
    enableGoogleTalkPlugin = true;
    enableBrowserpass = true;
  };

  packageOverrides = pkgs: rec {
    my_ = pkgs.buildEnv {
      name = "my_";
      paths = [ my_dev ];
    };
    my_dev = pkgs.buildEnv {
      name = "my_dev";
      paths = [ my_desktop ] ++ (with pkgs; [
        gnome3.seahorse
        chromium
        git gcc racket direnv meld file graphviz imagemagick
        mixxx
        gimp
        urbit
      ]);
    };
    my_desktop = pkgs.buildEnv {
      name = "my_desktop";
      paths = [ my_tools ] ++ (with pkgs; [
        firefox
        mpv evince geeqie feh pcmanfm
        xorg.xkbcomp xorg.xmodmap glxinfo xdg_utils
        light wob wev kanshi slurp grim swaylock
        alacritty st
        lxappearance gcolor2 paprefs pavucontrol
        transmission_gtk kdeconnect
        vanilla-dmz
      ]);
    };
    my_tools = pkgs.buildEnv {
      name = "my_tools";
      paths = with pkgs; [
        mosh iputils bind nmap tcpdump mtr wget iw wirelesstools gnupg mkpasswd
        htop bc mc-solarized
        pciutils lm_sensors
        sl bat fzf tree unzip psmisc nox dtach xxd
      ];
    };
    mc-solarized = pkgs.writeTextFile {
      name = "mc-solarized";
      destination = "/share/mc-solarized/solarized.ini";
      text =pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/peel/mc/05009685f34c48e0da58662214253c31c1620d47/solarized.ini";
        sha256 = "13p2flyn0i1c88xkycy2rk24d51can8ff31gh3c6djni3p981waq";
      };
    };
    my_emacs = pkgs.emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
      magit
      multiple-cursors
    ]));
  };
}
