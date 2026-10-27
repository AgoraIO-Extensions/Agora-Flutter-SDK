// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "agora_rtc_engine",
    platforms: [
        .iOS("12.0"),
    ],
    products: [
        .library(name: "agora-rtc-engine", targets: ["agora_rtc_engine"])
    ],
    dependencies: [
        .package(url: "https://github.com/AgoraIO/AgoraRtcEngine_iOS.git", revision: "721d25c986ed45b428b3cf6194fe5cd7a5d9a832"),
    ],
    targets: [
        .target(
            name: "agora_rtc_engine",
            dependencies: [
                .product(name: "AgoraInfra_iOS", package: "AgoraRtcEngine_iOS"),
                .product(name: "AIAEC", package: "AgoraRtcEngine_iOS"),
                .product(name: "ClearVision", package: "AgoraRtcEngine_iOS"),
                .product(name: "ContentInspect", package: "AgoraRtcEngine_iOS"),
                .product(name: "VQA", package: "AgoraRtcEngine_iOS"),
                .product(name: "SpatialAudio", package: "AgoraRtcEngine_iOS"),
                .product(name: "VirtualBackground", package: "AgoraRtcEngine_iOS"),
                .product(name: "AINS", package: "AgoraRtcEngine_iOS"),
                .product(name: "ReplayKit", package: "AgoraRtcEngine_iOS"),
                .product(name: "AudioBeauty", package: "AgoraRtcEngine_iOS"),
                .product(name: "RtcBasic", package: "AgoraRtcEngine_iOS"),
                "AgoraRtcWrapper"
            ],
            cSettings: [
                .headerSearchPath("include/agora_rtc_engine")
            ]
        ),
        .binaryTarget(
            name: "AgoraRtcWrapper",
            url: "https://download.agora.io/sdk/release/AgoraIrisRTC_iOS-4.6.4.1-build.1.zip",
            checksum: "12f04fc8e3256c7111d8455bbdb0037463937fc698a50cd5dce82857d2f3346c"
        )
    ]
)
