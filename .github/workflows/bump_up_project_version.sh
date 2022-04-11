#!/usr/bin/env bash

set -eux

replace_package_json_version () {
  local package_json="package.json"

  if [ ! -f "$package_json" ]; then
    echo "INFO: $package_json is not found"
    return 0
  fi

  < "$package_json" jq --arg VERSION "$VERSION" '.version |= $VERSION' > tmp && mv tmp "$package_json"
}

replace_upm_package_json_version () {
  local package_json="Assets/package.json"

  if [ ! -f "$package_json" ]; then
    echo "INFO: $package_json is not found"
    return 0
  fi

  < "$package_json" jq --arg VERSION "$VERSION" '.version |= $VERSION' > tmp && mv tmp "$package_json"
}

replace_project_settings_version () {
  local project_settings="ProjectSettings/ProjectSettings.asset"

  if [ ! -f "$project_settings" ]; then
    echo "ERROR: $project_settings is not found"
    exit 1
  fi

  local current_version
  current_version=$(< $project_settings grep "bundleVersion" | awk '{print $2}')
  if [ "$current_version" = "$VERSION" ]; then
    return 0
  fi

  sed -i "s/bundleVersion: $current_version/bundleVersion: $VERSION/" "$project_settings"
}

replace_package_json_version
replace_upm_package_json_version

if [ "$INCLUDE_PROJECT_SETTINGS" == "true" ]; then
  replace_project_settings_version
fi
