cask "jamly" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.1"
  sha256 arm:   "eaea8fd0869e3bc452a1bdaf702312900ffcc70581f71ee054a41eb1801c9fc0",
         intel: "a41e7cd02043f2337a8161ceaf13c2724162216883e641fb9937e623672b1ebe"

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
