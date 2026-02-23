{ config, pkgs, ... }:

{
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "phall" ];
  };

  users.users.phall = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      # Paste your SSH public key here, or rely on Tailscale SSH
    ];
  };

  programs.zsh.enable = true;
  programs.git.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
    curl
    wget
    htop
    btop
    tmux
    ripgrep
    fd
    jq
    bat
    eza
    fzf
    zoxide
    starship
    direnv
    stow
    age
    sops
    lazygit
    lazydocker
    unzip
  ];

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age.keyFile = "/home/phall/.config/sops/age/keys.txt";
  };

  networking.firewall.enable = true;

  security.sudo.wheelNeedsPassword = false;
}
