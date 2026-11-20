cask "adequate" do
  version "0.2.0"
  sha256 "92845ff51c1d8a92f319a39b634767f69dfa0ea4df8d5db0e80e3695fbfe67d7"

  url "https://github.com/NIH-Industries/adequate/releases/download/v#{version}/Adequate-#{version}.zip"
  name "Adequate"
  desc "Small WebKit browser with a sidebar, Spaces, pins, folders and split views"
  homepage "https://github.com/NIH-Industries/adequate"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Adequate.app"
  binary "#{appdir}/Adequate.app/Contents/Helpers/adequate"

  zap trash: [
    "~/Library/Application Support/Adequate",
    "~/Library/Caches/com.nih-industries.adequate",
    "~/Library/Preferences/com.nih-industries.adequate.plist",
    "~/Library/Saved Application State/com.nih-industries.adequate.savedState",
    "~/Library/WebKit/com.nih-industries.adequate",
  ]
end
