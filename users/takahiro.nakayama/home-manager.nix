{ isWSL, inputs, ... }:

{ config, lib, pkgs, ... }:

let
  user = "takahiro.nakayama";
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {
  home.stateVersion = "23.11";
  home.packages = with pkgs; [
    _1password
    _1password-gui
    alacritty
    awscli2
    azure-cli
    bat
    cargo
    curl
    delta
    deno
    eza
    fd
    findutils
    fzf
    gawk
    gh
    ghq
    gh-dash
    git
    github-copilot-cli
    gnugrep
    # gnused
    gnused-gsed
    gnutar
    google-cloud-sdk
    htop
    jq
    lazygit
    neovim
    nodejs_21
    ollama
    python3
    ripgrep
    ruby
    rustc
    rustfmt
    slack
    ssm-session-manager-plugin
    starship
    terraform
    terraform-ls
    typescript
    wget
    zip
    zellij
    zoxide
    zsh
    # java
    jdk # LTS
    # corretto11
    # corretto17
    # font
    inputs.nixpkgs-unstable.legacyPackages.${system}.nerdfonts
  ] ++ [
    # unstable packages
    inputs.nixpkgs-unstable.legacyPackages.${system}.devenv
    inputs.nixpkgs-unstable.legacyPackages.${system}.openssl_3_3
  ] ++ (lib.optionals isDarwin [
    # NOTE: add darwin only packages
    alt-tab-macos
    pronotes
  ]) ++ (lib.optionals (isLinux && !isWSL) [
    # NOTE: add linux only packages
  ]);
  # home.sessionPath = [];
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    PAGER = "less";
  };
  home.username = user;
  # launchd.enable
  editorconfig.enable = true;
  editorconfig.settings = {
    "*" = {
      charset = "utf-8";
      end_of_line = "lf";
      trim_trailing_whitespace = true;
      insert_final_newline = true;
      indent_style = "space";
      indent_size = 2;
    };
  };

  home.file = import ./lib/homeFiles.nix {};
  xdg = import ./lib/xdg.nix {};
  programs = import ./lib/programs.nix {
    inherit inputs config lib pkgs;
  };

}
