set -e

genericBuild

(
    echo -e "# This file was automatically generated by passthru.fetch-deps.\n# Please dont edit it manually, your changes might get overwritten!\n"
    @nugetToNix@/bin/nuget-to-nix "${NUGET_PACKAGES%/}"
) > deps.nix

mv deps.nix "$1"
echo "Succesfully wrote lockfile to $1"
