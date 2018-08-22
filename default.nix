with import <nixpkgs> {}; stdenv.mkDerivation rec {
  name = "rubyenv";
  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = with pkgs; [
    ruby
  ];

  shellHook = "
   export PATH=$PWD/bin:$PATH
  ";
}
