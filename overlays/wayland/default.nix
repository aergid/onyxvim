{channels, ...}: final: prev: {
  wayland =
    if prev.stdenv.isDarwin
    then
      prev.stdenv.mkDerivation {
        name = "wayland-stub";
        dontUnpack = true;
        dontBuild = true;
        installPhase = "mkdir -p $out";
      }
    else prev.wayland;

  wayland-scanner =
    if prev.stdenv.isDarwin
    then
      prev.stdenv.mkDerivation {
        name = "wayland-scanner-stub";
        dontUnpack = true;
        dontBuild = true;
        installPhase = "mkdir -p $out";
      }
    else prev.wayland-scanner;

  wayland-protocols =
    if prev.stdenv.isDarwin
    then
      prev.stdenv.mkDerivation {
        name = "wayland-protocols-stub";
        dontUnpack = true;
        dontBuild = true;
        installPhase = "mkdir -p $out";
      }
    else prev.wayland-protocols;

  wl-clipboard =
    if prev.stdenv.isDarwin
    then
      prev.stdenv.mkDerivation {
        name = "wl-clipboard";
        dontUnpack = true;
        dontBuild = true;
        installPhase = "mkdir -p $out";
      }
    else prev.wl-clipbooard;
}
