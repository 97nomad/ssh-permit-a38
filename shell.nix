{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {

  nativeBuildInputs = with pkgs; [ rustc cargo gcc ];
  buildInputs = with pkgs; [
    rustfmt
    clippy
    nixfmt
    pkg-config
    openssl
    cmake
    zlib
    rust-analyzer
    racer
  ];

  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
}
