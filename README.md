# homebrew-azoo-key-skkserv

[azoo-key-skkserv](https://github.com/gitusp/azoo-key-skkserv) の非公式 Homebrew tap です。

azooKey のかな漢字変換エンジンを使った SKK サーバ (skkserv) を cask で配布します。
GitHub Actions により毎日自動で最新リリースに追従します。

## インストール

```bash
brew tap gapul/azoo-key-skkserv
brew install --cask azoo-key-skkserv
```

## アップデート

```bash
brew update
brew upgrade --cask azoo-key-skkserv
```

## アンインストール

```bash
brew uninstall --cask azoo-key-skkserv
brew untap gapul/azoo-key-skkserv
```

## 詳細

| 項目 | 内容 |
|------|------|
| 対応アーキテクチャ | Universal (x86_64 / arm64) |
| 対応 macOS | Sonoma (14.0) 以降 |
| ダウンロード元 | [gitusp/azoo-key-skkserv](https://github.com/gitusp/azoo-key-skkserv) 公式リリース (DMG) |
| 自動更新 | 毎日 JST 15:00 に最新リリースを確認 |

## 免責事項

この tap は azoo-key-skkserv の非公式パッケージです。本体に関する問題は
[公式リポジトリ](https://github.com/gitusp/azoo-key-skkserv/issues) へご報告ください。
