{
  lib,
  rustPlatform,
  fetchurl,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "ablescript";
  version = "0.5.2";
  src = fetchurl {
    url = "https://git.ablecorp.us/AbleScript/able-script/archive/v${version}.tar.gz";
    sha256 = "wFmg9BTo2+JSVabWDIQAoLdT7OYuMxLxlvq6yL8g4EM=";
  };
  cargoSha256 = "2tBb8FdXknTbgFrjfO5ZM3O9OAnVuLVY/YcL8y/W7nA=";
  meta = with lib; {
    description = "A programming language designed to be bad";
    homepage = "https://git.ablecorp.us/AbleScript/able-script";
    downloadPage = "https://git.ablecorp.us/AbleScript/able-script/releases";
    license = licenses.mit;
    mainProgram = "ablescript_cli";
  };
}
