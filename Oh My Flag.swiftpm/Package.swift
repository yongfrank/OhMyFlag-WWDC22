// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Oh My Flag",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .iOSApplication(
            name: "Oh My Flag",
            targets: ["AppModule"],
            bundleIdentifier: "com.yongfrank.oh-my-flag",
            teamIdentifier: "L3P8YP4XRH",
            displayVersion: "1.0.0",
            bundleVersion: "5",
            appIcon: .asset("AppIcon"),
            accentColor: .asset("AccentColor"),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            capabilities: [
                .photoLibrary(purposeString: "Your drawings will save in your albums.")
            ],
            appCategory: .education
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "App"
        )
    ]
)
