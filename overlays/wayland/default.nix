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
}
