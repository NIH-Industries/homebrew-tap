cask "adequate" do
  version "0.1.0"
  sha256 "70cbef87a62e4f37fc52075f0202b5a916ab345a7d3732677adc5ff99ea16b6d"

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
