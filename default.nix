{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  sources = {
    papa = pkgs.fetchFromGitHub {
      owner = "qfpl";
      repo = "papa";
      rev = "536b0a9243802347c299e077b5d85beb80d3a4a1";
      sha256 = "10wx0z5cd8dajr3rdskaq64v42ppa8dbb3rs3jyj872218xjz6nr";
    };
  };

  modifiedHaskellPackages = haskellPackages.override {
    overrides = self: super: import sources.papa self // {
      parsers = pkgs.haskell.lib.dontCheck super.parsers;
      tagsoup-selection = pkgs.haskell.lib.doJailbreak super.tagsoup-selection;
      polyparse = self.callHackage "polyparse" "1.12.1" {};
    };
  };

  _or = modifiedHaskellPackages.callPackage ./or.nix {};

in
  _or
