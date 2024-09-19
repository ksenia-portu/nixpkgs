# generated by zon2nix (https://github.com/Cloudef/zig2nix)

{
  lib,
  linkFarm,
  fetchurl,
  fetchgit,
  runCommandLocal,
  zig,
  name ? "zig-packages",
}:

let
  unpackZigArtifact =
    { name, artifact }:
    runCommandLocal name { nativeBuildInputs = [ zig ]; } ''
      hash="$(zig fetch --global-cache-dir "$TMPDIR" ${artifact})"
      mv "$TMPDIR/p/$hash" "$out"
      chmod 755 "$out"
    '';

  fetchZig =
    {
      name,
      url,
      hash,
    }:
    let
      artifact = fetchurl { inherit url hash; };
    in
    unpackZigArtifact { inherit name artifact; };

  fetchGitZig =
    {
      name,
      url,
      hash,
    }:
    let
      parts = lib.splitString "#" url;
      base = lib.elemAt parts 0;
      rev = lib.elemAt parts 1;
    in
    fetchgit {
      inherit name rev hash;
      url = base;
      deepClone = false;
    };

  fetchZigArtifact =
    {
      name,
      url,
      hash,
    }:
    let
      parts = lib.splitString "://" url;
      proto = lib.elemAt parts 0;
      path = lib.elemAt parts 1;
      fetcher = {
        "git+http" = fetchGitZig {
          inherit name hash;
          url = "http://${path}";
        };
        "git+https" = fetchGitZig {
          inherit name hash;
          url = "https://${path}";
        };
        http = fetchZig {
          inherit name hash;
          url = "http://${path}";
        };
        https = fetchZig {
          inherit name hash;
          url = "https://${path}";
        };
        file = unpackZigArtifact {
          inherit name;
          artifact = /. + path;
        };
      };
    in
    fetcher.${proto};
in
linkFarm name [
  {
    name = "122014e73fd712190e109950837b97f6143f02d7e2b6986e1db70b6f4aadb5ba6a0d";
    path = fetchZigArtifact {
      name = "clap";
      url = "https://github.com/Hejsil/zig-clap/archive/8c98e6404b22aafc0184e999d8f068b81cc22fa1.tar.gz";
      hash = "sha256-3P9LyIlq4eNMOe+/jdVJgECfzveSUuRzTf9yhT4t8Zo=";
    };
  }
  {
    name = "12209b971367b4066d40ecad4728e6fdffc4cc4f19356d424c2de57f5b69ac7a619a";
    path = fetchZigArtifact {
      name = "zigini";
      url = "https://github.com/Kawaii-Ash/zigini/archive/0bba97a12582928e097f4074cc746c43351ba4c8.tar.gz";
      hash = "sha256-OdaJ5tqmk2MPwaAbpK4HRD/CcQCN+Cjj8U63BqUcFMs=";
    };
  }
  {
    name = "1220b0979ea9891fa4aeb85748fc42bc4b24039d9c99a4d65d893fb1c83e921efad8";
    path = fetchZigArtifact {
      name = "ini";
      url = "https://github.com/ziglibs/ini/archive/e18d36665905c1e7ba0c1ce3e8780076b33e3002.tar.gz";
      hash = "sha256-RQ6OPJBqqH7PCL+xiI58JT7vnIo6zbwpLWn+byZO5iM=";
    };
  }
]
