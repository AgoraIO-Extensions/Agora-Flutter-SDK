// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "agora_rtc_engine",
    platforms: [
        .macOS("10.14")
    ],
    products: [
        .library(name: "agora-rtc-engine", targets: ["agora_rtc_engine"])
    ],
    dependencies: [
        .package(url: "https://github.com/AgoraIO/AgoraRtcEngine_macOS.git", exact: "4.5.3"),
    ],
    targets: [
        .target(
            name: "agora_rtc_engine",
            dependencies: [
                .product(name: "RtcBasic", package: "AgoraRtcEngine_macOS"),
                "AgoraRtcWrapper"
            ],
            cSettings: [
                .headerSearchPath("include/agora_rtc_engine")
            ],
            cxxSettings: [
                .unsafeFlags(["-std=c++14"])
            ]
        ),
        .binaryTarget(
            name: "AgoraRtcWrapper",
            url: "https://download.agora.io/sdk/release/AgoraIrisRTC_macOS-4.5.3-build.1.zip",
            checksum: "4efe7f122383cf9e4ca7978a92b9ce5d7ea60009c1602d5b9b8181cbf7e5cfc2"
        )
    ]
)
