#!/usr/bin/env bash

set -eux

update_addressables() {
  if [ "$TARGET_ADDRESSABLES" != "true" ]; then
    return
  fi

  if [ -f "Assets/AddressableAssetsData/AddressableAssetSettings.asset" ]; then
    file_name="Assets/AddressableAssetsData/AddressableAssetSettings.asset"
    current_version=$(< $file_name grep "m_overridePlayerVersion" | awk '{print $2}')
    next_version=$(printf "%0${#current_version}d" $((current_version + 1)))
    sed -i "s/m_overridePlayerVersion: $current_version/m_overridePlayerVersion: $next_version/" "$file_name"

    echo -e "* \`$file_name\`: $current_version => $next_version" >> message
  fi

  if [ -f "Assets/Settings/PavilionSetting.asset" ]; then
    file_name="Assets/Settings/PavilionSetting.asset"
    current_version=$(< $file_name grep "addressablesCatalogVersion" | awk '{print $2}')
    next_version=$((current_version + 1))
    sed -i "s/addressablesCatalogVersion: $current_version/addressablesCatalogVersion: $next_version/" "$file_name"

    echo -e "* \`$file_name\`: $current_version => $next_version" >> message
  fi

  if [ -f "Assets/Booth/Settings/PavilionSetting.asset" ]; then
    file_name="Assets/Booth/Settings/PavilionSetting.asset"
    current_version=$(< $file_name grep "addressablesCatalogVersion" | awk '{print $2}')
    next_version=$((current_version + 1))
    sed -i "s/addressablesCatalogVersion: $current_version/addressablesCatalogVersion: $next_version/" "$file_name"

    echo -e "* \`$file_name\`: $current_version => $next_version" >> message
  fi
}

update_asset_bundle() {
  if [ "$TARGET_ASSET_BUNDLE" != "true" ]; then
    return
  fi

  if [ ! -f "Assets/Resources/Entities/ProjectContextEntity.asset" ]; then
    return
  fi

  file_name="Assets/Resources/Entities/ProjectContextEntity.asset"
  current_version=$(< $file_name grep "assetBundleSingleManifestVersion" | awk '{print $2}')
  next_version=$((current_version + 1))
  sed -i "s/assetBundleSingleManifestVersion: $current_version/assetBundleSingleManifestVersion: $next_version/" "$file_name"

  echo -e "* \`$file_name\`: $current_version => $next_version" >> message
}

echo -e "Asset のバージョンを更新しました" >> message
update_addressables
update_asset_bundle
