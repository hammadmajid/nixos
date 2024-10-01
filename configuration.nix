{
  config,
  pkgs,
  unstable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Temporarily allow insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # Define your hostname.
  networking.hostName = "nixos";

  # Enable flakes.
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Karachi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable flatpak
  services.flatpak.enable = true;
  services.flatpak.packages = [
    "com.github.finefindus.eyedropper"
    "de.schmidhuberj.tubefeeder"
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hammad = {
    isNormalUser = true;
    description = "Hammad Majid";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      # Apps
      pkgs._1password-gui
      pkgs._1password
      pkgs.anydesk
      pkgs.brave
      pkgs.cozy
      pkgs.foliate
      pkgs.fragments
      pkgs.gnome-solanum
      pkgs.jetbrains.phpstorm
      pkgs.kitty
      pkgs.libreoffice-still
      pkgs.mediawriter
      pkgs.obsidian
      pkgs.pods
      pkgs.protonvpn-gui
      pkgs.spot
      pkgs.sublime4
      unstable.vscodium

      # Tools
      pkgs.atuin
      pkgs.bat
      pkgs.bear
      pkgs.bottom
      unstable.bun
      pkgs.eza
      pkgs.file
      pkgs.fd
      pkgs.gh
      pkgs.just
      pkgs.kanata
      pkgs.lazygit
      pkgs.ncdu
      pkgs.nasm
      pkgs.nodePackages.wrangler
      pkgs.php
      pkgs.php83Packages.composer
      pkgs.podman
      pkgs.podman-compose
      pkgs.python312Packages.django_5
      pkgs.python312Packages.pip
      pkgs.python312Packages.python-lsp-server
      pkgs.rclone
      pkgs.ripgrep
      pkgs.rye
      pkgs.starship
      pkgs.sccache
      pkgs.tldr
      pkgs.tree
      pkgs.typst
      pkgs.valgrind
      pkgs.unzip
      pkgs.wordpress
      pkgs.wp-cli
      pkgs.xclip
      pkgs.yazi
      pkgs.zellij
      pkgs.zip
      pkgs.zoxide

      # LSPs
      pkgs.alejandra
      pkgs.docker-compose-language-service
      pkgs.dockerfile-language-server-nodejs
      pkgs.marksman
      pkgs.markdown-oxide
      pkgs.nixd
      pkgs.nodePackages.svelte-language-server
      pkgs.nodePackages.typescript-language-server
      pkgs.rust-analyzer
      pkgs.tailwindcss-language-server
      pkgs.typst-lsp
      pkgs.vscode-langservers-extracted
      pkgs.yaml-language-server
    ];
    shell = pkgs.fish;
  };

  # services.mysql = {
  #     enable = true;
  #     # dataDir = "/var/lib/mysql";
  #     package = pkgs.mariadb;
  # };

  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    binutils
    clang
    clang-tools
    clang-manpages
    cmake
    fish
    git
    gnumake
    helix
    nodejs_22
    python3
    rustup
  ];

  programs.fish.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["hammad"];
  };
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [];

  environment.variables = {
    EDITOR = "hx";
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  # Enable NextDNS
    services.resolved = {
    enable = true;
    extraConfig = ''
      [Resolve]
      DNS=45.90.28.0#7cff39.dns.nextdns.io
      DNS=2a07:a8c0::#7cff39.dns.nextdns.io
      DNS=45.90.30.0#7cff39.dns.nextdns.io
      DNS=2a07:a8c1::#7cff39.dns.nextdns.io
      DNSOverTLS=yes
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable kanata service
  services.kanata.enable = true;
  services.kanata.keyboards.default.config = ''
    (defsrc
      caps)

    (deflayermap (default-layer)
    ;; tap caps lock as caps lock, hold caps lock as left control
    caps (tap-hold 100 100 esc lctl))
  '';

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
