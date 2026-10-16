{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  rustToolchain = inputs.fenix.packages."${pkgs.system}".complete.withComponents [
    "cargo"
    "clippy"
    "rust-src"
    "rustc"
    "rustfmt"
    "rust-analyzer"
    "llvm-tools-preview"
  ];

in {
  home.packages = [
    rustToolchain

    pkgs.cargo-binstall

    pkgs.espflash
    pkgs.cargo-espflash
    pkgs.esp-generate

    pkgs.pkg-config
    pkgs.openssl
    pkgs.libusb1
    pkgs.gcc
    pkgs.gnumake
  ];

  home.sessionVariables = {
    CARGO_HOME = "${config.home.homeDirectory}/.cargo";
    RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.cargo/bin"
  ];
}
