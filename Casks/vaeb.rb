# typed: strict
# frozen_string_literal: true

cask "vaeb" do
  version "0.8.1"
  sha256 "12fd7963f29e1f08e170362d351e9fcf1fcd16ee466b7364943af2c598015e16"

  url "https://github.com/vaeb-ai/homebrew-tap/releases/download/v#{version}/Vaeb-#{version}.zip"
  name "Vaeb"
  desc "Terminal for agentic coding, built on libghostty"
  homepage "https://vaeb.ai/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Vaeb.app"

  # Vaeb is not notarized: remove the quarantine flag so macOS opens it.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Vaeb.app"],
        must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/Vaeb",
    "~/Library/Caches/ai.vaeb.app",
    "~/Library/Preferences/ai.vaeb.app.plist",
    "~/Library/Saved Application State/ai.vaeb.app.savedState",
  ]
end
