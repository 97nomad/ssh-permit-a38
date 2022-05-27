{
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };
  outputs = { self, nixpkgs, ... }:
    let onPkgs = fn: builtins.mapAttrs fn nixpkgs.legacyPackages;
    in {
      defaultPackage = onPkgs (_: pkgs:
        pkgs.rustPlatform.buildRustPackage {
          name = "ssh-permit-a38";
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;
          nativeBuildInputs = with pkgs; [ pkg-config ];
          buildInputs = with pkgs; [ openssl cmake zlib ];
        });

      devShell = onPkgs (_: pkgs:
        with pkgs;
        mkShell {
          nativeBuildInputs = [ rustc cargo gcc ];
          buildInputs = [
            rustfmt
            clippy
            nixfmt
            pkg-config
            openssl
            cmake
            zlib
            rust-analyzer
          ];
          RUST_SRC_PATH = rustPlatform.rustLibSrc;
          PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
        });
    };

}
