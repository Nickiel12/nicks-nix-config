{ stdenv, lib, fetchurl, autoPatchelfHook, unzip, curl, gcc }:

stdenv.mkDerivation rec {
  pname = "minecraft bedrock server";
  version = "1.20.1";

  src = fetchurl {
    url = "https://minecraft.azureedge.net/bin-linux/bedrock-server-1.20.1.02.zip";
    sha256 = "sha256-H7OAdB1EzcvdGHWRUD/K8/P8rqBkteuxtNdx/Fp2ZTM=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    unzip
  ];

  buildInputs = [
    curl
    gcc.cc.lib
  ];

  sourceRoot = ".";
  installPhase = ''
    mkdir $out
    mkdir $out/bin
    unzip $src -d $out
    install -m755 -D $out/bedrock_server $out/bin/bedrock-server
  '';


  meta = with lib; {
    description = "Minecraft Bedrock Server";
    platforms = platforms.linux;
  };

}
