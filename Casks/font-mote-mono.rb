cask "font-mote-mono" do
  version "0.1.1"
  sha256 "ef097089356c0b671d43b33f1b6b3145858ba3f4d25f94e797dbca34b95bcc8e"

  url "https://github.com/NIH-Industries/mote-mono/releases/download/v#{version}/MoteMono-#{version}.zip"
  name "Mote Mono"
  desc "Rounded monospace coding font built on Iosevka"
  homepage "https://github.com/NIH-Industries/mote-mono"

  livecheck do
    url :url
    strategy :github_latest
  end

  font "MoteMono-Bold.ttf"
  font "MoteMono-BoldItalic.ttf"
  font "MoteMono-Italic.ttf"
  font "MoteMono-Light.ttf"
  font "MoteMono-LightItalic.ttf"
  font "MoteMono-Medium.ttf"
  font "MoteMono-MediumItalic.ttf"
  font "MoteMono-Regular.ttf"
end
