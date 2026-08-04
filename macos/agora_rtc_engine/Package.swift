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
        // agora-spm-updater:managed-packages-start
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(url: "https://github.com/AgoraIO/AgoraRtcEngine_macOS.git", exact: "4.6.2"),
        // agora-spm-updater:managed-packages-end
    ],
    targets: [
        .target(
            name: "agora_rtc_engine",
            dependencies: [
                // agora-spm-updater:managed-products-start
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "RtcBasic", package: "AgoraRtcEngine_macOS"),
                // agora-spm-updater:managed-products-end
                "AgoraRtcWrapper"
            ],
            cSettings: [
                .headerSearchPath("include/agora_rtc_engine")
            ]
        ),
        .binaryTarget(
            name: "AgoraRtcWrapper",
            url: "https://download.agora.io/sdk/release/AgoraIrisRTC_macOS2-4.6.2-build.1.zip",
            checksum: "dbfe2db86b0cb2c1012202212248bd6588173020c357dc13fc5a6dcf0a7b97cf"
        )
    ],
    cxxLanguageStandard: .cxx14
)
