#!/usr/bin/env bash

set -eux

# v5.0.0_うんちゃらみたいなブランチを作ることもあるので末尾のチェックはしない
version=$(echo "$BASE" | sed -r 's/^.*([0-9]+)\.([0-9]+)\.([0-9]+).*/\1\.\2\.\3/')
# shellcheck disable=SC2001
version_with_v=$(echo "$version" | sed -e "s/^\([0-9]\)/v\1/") # SC2001 の通りにやると正常に置換されない

echo "::set-output name=VERSION::$version"
echo "::set-output name=VERSION_WITH_V::$version_with_v"
