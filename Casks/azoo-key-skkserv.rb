cask "azoo-key-skkserv" do
  version "0.4.0"
  sha256 "b5935f4e3226f8af232a778ce083ad823075bee4ff2e7ad71f6a9d634dfef370"

  url "https://github.com/gitusp/azoo-key-skkserv/releases/download/v#{version}/azoo-key-skkserv-#{version}.dmg"
  name "azooKey skkserv"
  desc "SKK server backed by the azooKey kana-kanji conversion engine"
  homepage "https://github.com/gitusp/azoo-key-skkserv"

  depends_on macos: :sonoma

  app "azooKey skkserv.app"

  # 配布 .app は LSUIElement 未設定で Dock に常駐アイコンが出る。SKK サーバーは
  # UI 不要の裏方なので LSUIElement を注入して隠す。Info.plist を書き換えると
  # Developer ID 署名が壊れ、内部 llama.framework と Team ID 不一致で dyld ロードが
  # 失敗するため、framework ごと ad-hoc 再署名して Team ID を揃える (entitlements は保持)。
  # LSUIElement 未設定のとき (＝新バイナリ) だけ走るので upgrade でも自動追従する。
  # 上流 (gitusp/azoo-key-skkserv) に LSUIElement を入れる PR が通れば、このブロックは不要。
  # lsregister は sandbox 内だと LaunchServices に届かないことがあるので失敗は無視する
  # (LaunchServices は次回起動時にも Info.plist を読み直す)。
  postflight_steps do
    run "/bin/bash", args: ["-c", <<~SH]
      set -e
      app='{{appdir}}/azooKey skkserv.app'
      pl="$app/Contents/Info.plist"
      if [ "$(/usr/libexec/PlistBuddy -c 'Print :LSUIElement' "$pl" 2>/dev/null)" != "true" ]; then
        /usr/libexec/PlistBuddy -c 'Add :LSUIElement bool true' "$pl"
        ent="$(/usr/bin/mktemp)"
        /usr/bin/codesign -d --entitlements "$ent" --xml "$app" 2>/dev/null
        /usr/bin/find "$app/Contents/Frameworks" -type d -name '*.framework' -exec /usr/bin/codesign --force --sign - {} +
        /usr/bin/find "$app/Contents/Frameworks" -type f -name '*.dylib' -exec /usr/bin/codesign --force --sign - {} +
        /usr/bin/codesign --force --sign - --entitlements "$ent" "$app"
        /bin/rm -f "$ent"
        /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f "$app" || true
      fi
    SH
  end

  zap trash: "~/Library/Preferences/io.github.gitusp.azoo-key-skkserv.plist"
end
