cask "jamly" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.5"
  sha256 arm:   "c89a6cf66e1a562f906c52349f6901796146b143844682f93162ae5448c4a9d9",
         intel: "338d3f74c8b5396e14a36780c5631afc640bccc433a1bd3a614ccd886ea8387c"

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
