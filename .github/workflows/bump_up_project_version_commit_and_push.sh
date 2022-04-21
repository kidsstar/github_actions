#!/usr/bin/env bash

set -eux

if [ -z "$(git status --porcelain)" ]; then
  exit 0
fi

if [ -f "package.json" ]; then
  git add package.json
fi

if [ -f "Assets/package.json" ]; then
  git add Assets/package.json
fi

if [ -f "Assets/Settings/PavilionSetting.asset" ]; then
  git add Assets/Settings/PavilionSetting.asset
fi

if [ -f "Assets/Booth/Settings/PavilionSetting.asset" ]; then
  git add Assets/Booth/Settings/PavilionSetting.asset
fi

git add ProjectSettings/ProjectSettings.asset
git commit -m ":up: Bump up project version to $VERSION"
git push origin "$BRANCH_NAME"
