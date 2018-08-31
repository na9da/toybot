with import <nixpkgs> {}; stdenv.mkDerivation rec {
  name = "rubyenv";
  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = with pkgs; [
    ruby_2_5
  ];

  shellHook = "
   export PATH=$PWD/bin:$PATH
  ";
}
