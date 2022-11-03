{
  lib,
  rustPlatform,
  fetchurl,
  version ? null,
  src ? null,
  cargoSha256 ? lib.fakeSha256,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "ablescript";
  inherit version src cargoSha256;

  meta = with lib; {
    description = "A programming language designed to be bad";
    homepage = "https://git.ablecorp.us/AbleScript/able-script";
    downloadPage = "https://git.ablecorp.us/AbleScript/able-script/releases";
    license = licenses.mit;
    mainProgram = "ablescript_cli";
  };
}
