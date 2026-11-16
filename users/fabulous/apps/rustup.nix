{ config, pkgs, ... }:

let
  stateDir = "${config.home.homeDirectory}/.local/state/apps/rustup";

  rustToolchain = pkgs.rust-bin.stable.latest.default.override {
    extensions = [
      "rust-src"
      "rust-analyzer"
      "clippy"
      "rustfmt"
    ];
    targets = [
      "x86_64-unknown-linux-gnu" # Stable NixOS (native host)
      "x86_64-pc-windows-gnu"    # Stable Windows 11 (x86_64)
      "aarch64-linux-android"    # Stable Android (Samsung Galaxy Tab S12 Ultra ARM64)
    ];
  };
in
{
  home.packages = [
    rustToolchain
    pkgs.pkgsCross.mingwW64.stdenv.cc # Cross-linker for Windows
    pkgs.cargo-ndk                    # Helper for compiling Android libraries with NDK
    pkgs.cargo-binstall               # Binary installer for cargo crates
    pkgs.espup                        # Toolchain manager for ESP32/Xtensa
    pkgs.espflash                     # Serial flashing utility for ESP32
    pkgs.esp-generate                 # Template generator for ESP32 projects
  ];

  # Confine Cargo, Rustup, and Espressif state strictly to ~/.local/state/apps/rustup/
  home.sessionVariables = {
    CARGO_HOME = "${stateDir}/cargo";
    RUSTUP_HOME = "${stateDir}/rustup";
    ESPRESSIF_HOME = "${stateDir}/espressif";

    # Automatic linker mapping for Windows 11 cross-compilation
    CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER = "x86_64-w64-mingw32-gcc";
  };
}

