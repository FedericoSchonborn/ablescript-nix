{
  lib,
  rustPlatform,
  fetchurl,
  version,
  src,
  sha256 ? lib.fakeSha256,
  cargoSha256 ? lib.fakeSha256,
  ...
}:
rustPlatform.buildRustPackage rec {
  inherit version src cargoSha256;

  pname = "ablescript";
  meta = with lib; {
    description = "A programming language designed to be bad";
    homepage = "https://git.ablecorp.us/AbleScript/able-script";
    downloadPage = "https://git.ablecorp.us/AbleScript/able-script/releases";
    license = licenses.mit;
    mainProgram = "ablescript_cli";
  };
}
