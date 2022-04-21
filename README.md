KidsStar 内で Reusable Workflow を使って共有している GitHub Actions

* GitHub の制限で Reusable Workflow で外部から参照する場合にも .github/workflows 以下に置かないといけないようなので、そこに置いています

## bump_up_project_version.yml

* バージョン用のブランチを作成すると以下のファイル内のバージョン情報をそのバージョンに置き換える Workflow です
  * `Assets/package.json`
  * `Assets/Booth/Settings/PavilionSetting.asset`
  * `Assets/Settings/PavilionSetting.asset`
  * `package.json`
  * `ProjectSettings/ProjectSettings.asset`

## create_version_branch.yml

* バージョン用のブランチを作成するための Workflow です
