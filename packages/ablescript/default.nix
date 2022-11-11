{
  lib,
  rustPlatform,
  fetchFromGitea,
  stable ? true,
  version ? null,
  rev ? null,
  sha256 ? lib.fakeSha256,
  cargoSha256 ? lib.fakeSha256,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "ablescript";
  inherit version cargoSha256;

  src = fetchFromGitea {
    domain = "git.ablecorp.us";
    owner = "AbleScript";
    repo = "ablescript";
    rev =
      if stable
      then "v" + version
      else rev;
    inherit sha256;
  };

  meta = with lib; {
    description = "A programming language designed to be bad";
    homepage = "https://git.ablecorp.us/AbleScript/able-script";
    downloadPage = "https://git.ablecorp.us/AbleScript/able-script/releases";
    license = licenses.mit;
    mainProgram = "ablescript_cli";
  };
}
