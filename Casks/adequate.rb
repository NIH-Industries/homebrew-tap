cask "adequate" do
  version "0.2.1"
  sha256 "f5e6d8f1b648ebbf7969283b446cbebc0d8f2ee765b31f271674fcc4af7d10af"

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
