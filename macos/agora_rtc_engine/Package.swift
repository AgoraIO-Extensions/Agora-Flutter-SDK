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
        .package(url: "https://github.com/AgoraIO/AgoraRtcEngine_macOS.git", exact: "4.6.2"),
    ],
    targets: [
        .target(
            name: "agora_rtc_engine",
            dependencies: [
                .product(name: "RtcBasic", package: "AgoraRtcEngine_macOS"),
                .product(name: "AINS", package: "AgoraRtcEngine_macOS"),
                .product(name: "AINSLL", package: "AgoraRtcEngine_macOS"),
                .product(name: "AudioBeauty", package: "AgoraRtcEngine_macOS"),
                .product(name: "ClearVision", package: "AgoraRtcEngine_macOS"),
                .product(name: "ContentInspect", package: "AgoraRtcEngine_macOS"),
                .product(name: "SpatialAudio", package: "AgoraRtcEngine_macOS"),
                .product(name: "VirtualBackground", package: "AgoraRtcEngine_macOS"),
                .product(name: "AIAEC", package: "AgoraRtcEngine_macOS"),
                .product(name: "AIAECLL", package: "AgoraRtcEngine_macOS"),
                .product(name: "VQA", package: "AgoraRtcEngine_macOS"),
                .product(name: "FaceDetection", package: "AgoraRtcEngine_macOS"),
                .product(name: "FaceCapture", package: "AgoraRtcEngine_macOS"),
                .product(name: "LipSync", package: "AgoraRtcEngine_macOS"),
                .product(name: "VideoCodecEnc", package: "AgoraRtcEngine_macOS"),
                .product(name: "VideoAv1CodecEnc", package: "AgoraRtcEngine_macOS"),
                .product(name: "ScreenCapture", package: "AgoraRtcEngine_macOS"),
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
            url: "https://download.agora.io/sdk/release/AgoraIrisRTC_macOS-4.6.4-build.3.zip",
            checksum: "8d5de39bfed309073a38d0f7c409140a44e243f0a92c8bc5c3def9bb9b5d2328"
        )
    ]
)
