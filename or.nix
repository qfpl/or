{ mkDerivation, base, checkers, lens, papa, QuickCheck, semigroups
, stdenv, tasty, tasty-hunit, tasty-quickcheck
}:
mkDerivation {
  pname = "or";
  version = "0.0.1";
  src = ./.;
  libraryHaskellDepends = [ base lens papa semigroups ];
  testHaskellDepends = [
    base checkers lens QuickCheck tasty tasty-hunit tasty-quickcheck
  ];
  homepage = "https://github.com/qfpl/or";
  description = "Three data types";
  license = stdenv.lib.licenses.bsd3;
}
