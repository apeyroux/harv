{ mkDerivation, aeson, base, har, hpack, optparse-applicative
, stdenv, text
}:
mkDerivation {
  pname = "harv";
  version = "0.0.1";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [
    aeson base har optparse-applicative text
  ];
  preConfigure = "hpack";
  homepage = "https://github.com/apeyroux/harv#readme";
  license = stdenv.lib.licenses.bsd3;
}
