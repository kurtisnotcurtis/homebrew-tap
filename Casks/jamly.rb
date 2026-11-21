cask "jamly" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.2"
  sha256 arm:   "5c1aa6f9b2efa27cdb6be0eebd8c2db7e90a04eef99349c5a2119654d48d7c08",
         intel: "19600a6ede8267e6be5ac43de69a9a3c26b830908490907a39fd100337e0bffd"

  url "https://github.com/kurtisnotcurtis/jamly/releases/download/v#{version}/Jamly-#{version}-darwin-#{arch}.zip"
  name "Jamly"
  desc "Split media URLs or local audio into drums, drumless, or multi-stem tracks locally"
  homepage "https://kurtisnotcurtis.github.io/jamly/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Jamly.app"
  command_wrapper "jamly",
                  executable: "#{appdir}/Jamly.app/Contents/MacOS/Jamly"
  command_wrapper "jamly-runtime",
                  executable: "#{appdir}/Jamly.app/Contents/MacOS/jamly-runtime"

  zap trash: [
    "~/Library/Application Support/jamly",
    "~/Library/LaunchAgents/com.jamly.backend.plist",
    "~/Library/Saved Application State/com.jamly.companion.savedState",
  ]

  caveats <<~EOS
    Jamly.app is currently an unsigned, unnotarized preview build.
    On first launch, macOS Gatekeeper may block it; open Jamly from
    System Settings -> Privacy & Security (Open Anyway), or run:
      xattr -dr com.apple.quarantine "#{appdir}/Jamly.app"
  EOS
end
