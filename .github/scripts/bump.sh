#!/usr/bin/env bash
# Sets url and sha256 of Formula/create-ln-app.rb to a version on npm.
# Usage: .github/scripts/bump.sh [version]. With no version, the script uses the npm latest version.
# The script writes the version to GITHUB_ENV if GITHUB_ENV is set.

set -euo pipefail

formula=Formula/create-ln-app.rb
version=${1:-}
if [ -z "$version" ]; then
  version=$(curl -fsSL https://registry.npmjs.org/create-ln-app/latest | jq -r .version)
fi
if ! [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "The version '$version' is not valid. Use the form 1.6.0." >&2
  exit 1
fi

url="https://registry.npmjs.org/create-ln-app/-/create-ln-app-$version.tgz"
if grep -q "^  url \"$url\"$" "$formula"; then
  echo "The formula is already at create-ln-app $version."
  exit 1
fi

sha256=$(curl -fsSL "$url" | sha256sum | cut -d ' ' -f 1)
sed -i -E \
  -e "s|^  url \".*\"$|  url \"$url\"|" \
  -e "s|^  sha256 \".*\"$|  sha256 \"$sha256\"|" \
  "$formula"
grep -q "^  sha256 \"$sha256\"$" "$formula"

echo "The formula is now at create-ln-app $version."
if [ -n "${GITHUB_ENV:-}" ]; then
  echo "VERSION=$version" >> "$GITHUB_ENV"
fi
