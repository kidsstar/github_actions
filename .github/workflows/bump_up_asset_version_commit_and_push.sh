#!/usr/bin/env bash

set -eux

. .github/actions/shared/.github/workflows/shared.sh

git_add "Assets/AddressableAssetsData/AddressableAssetSettings.asset"
git_add "Assets/Settings/PavilionSetting.asset"
git_add "Assets/Resources/Entities/ProjectContextEntity.asset"

if [ "$(is_git_stage_changes)" -eq 0 ]; then
  echo "INFO: there is no updated files"
  echo "::set-output name=IS_COMMIT::0"
  exit 0
else
  echo "::set-output name=IS_COMMIT::1"
fi

branch="bot/bump_up_asset_version"

git checkout -b "$branch"
git commit -m ":up: Bump up asset version"
git push origin "$branch"
