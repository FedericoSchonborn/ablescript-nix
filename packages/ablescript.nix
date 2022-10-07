{
  lib,
  rustPlatform,
  fetchurl,
  version,
  commit ? "",
  sha256 ? lib.fakeSha256,
  cargoSha256 ? lib.fakeSha256,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "ablescript";
  inherit version;

  src = fetchurl {
    url =
      if commit == ""
      then "https://git.ablecorp.us/AbleScript/able-script/archive/v${version}.tar.gz"
      else "https://git.ablecorp.us/AbleScript/able-script/archive/${commit}.tar.gz";
    inherit sha256;
  };
  inherit cargoSha256;

  meta = with lib; {
    description = "A programming language designed to be bad";
    homepage = "https://git.ablecorp.us/AbleScript/able-script";
    downloadPage = "https://git.ablecorp.us/AbleScript/able-script/releases";
    license = licenses.mit;
    mainProgram = "ablescript_cli";
  };
}
