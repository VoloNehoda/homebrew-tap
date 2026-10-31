cask "etherlynx-battery" do
  version "0.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/VoloNehoda/etherlynx-battery/releases/download/v#{version}/Etherlynx-Battery-#{version}.dmg"
  name "Etherlynx Battery"
  desc "Menu bar battery monitor with charge limit, power flow and alerts"
  homepage "https://github.com/VoloNehoda/etherlynx-battery"

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Etherlynx Battery.app"

  # Ad-hoc signed, not notarized: without this Gatekeeper blocks the first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Etherlynx Battery.app"]
  end

  # The charge-limit helper restores normal charging when launchd stops it.
  uninstall launchctl: "xyz.etherlynx.battery.helper",
            quit:      "xyz.etherlynx.battery",
            delete:    [
              "/Library/LaunchDaemons/xyz.etherlynx.battery.helper.plist",
              "/Library/PrivilegedHelperTools/xyz.etherlynx.battery.helper",
            ]

  zap trash: [
    "/Library/Application Support/Etherlynx Battery",
    "~/Library/Application Support/Etherlynx Battery",
    "~/Library/Preferences/xyz.etherlynx.battery.plist",
  ]
end
