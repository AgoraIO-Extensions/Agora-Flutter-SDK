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
        .package(url: "https://github.com/AgoraIO/AgoraRtcEngine_iOS.git", exact: "4.5.3-rc.70")
    ],
    targets: [
        .target(
            name: "agora_rtc_engine",
            dependencies: [
                .product(name: "RtcBasic", package: "AgoraRtcEngine_iOS"),
                .product(name: "AINS", package: "AgoraRtcEngine_iOS"),
                .product(name: "AINSLL", package: "AgoraRtcEngine_iOS"),
                .product(name: "AudioBeauty", package: "AgoraRtcEngine_iOS"),
                .product(name: "ClearVision", package: "AgoraRtcEngine_iOS"),
                .product(name: "ContentInspect", package: "AgoraRtcEngine_iOS"),
                .product(name: "SpatialAudio", package: "AgoraRtcEngine_iOS"),
                .product(name: "VirtualBackground", package: "AgoraRtcEngine_iOS"),
                .product(name: "AIAEC", package: "AgoraRtcEngine_iOS"),
                .product(name: "AIAECLL", package: "AgoraRtcEngine_iOS"),
                .product(name: "VQA", package: "AgoraRtcEngine_iOS"),
                .product(name: "FaceDetection", package: "AgoraRtcEngine_iOS"),
                .product(name: "FaceCapture", package: "AgoraRtcEngine_iOS"),
                .product(name: "LipSync", package: "AgoraRtcEngine_iOS"),
                .product(name: "VideoCodecEnc", package: "AgoraRtcEngine_iOS"),
                .product(name: "VideoAv1CodecEnc", package: "AgoraRtcEngine_iOS"),
                .product(name: "ReplayKit", package: "AgoraRtcEngine_iOS"),
                "AgoraRtcWrapper"
            ],
            cSettings: [
                .headerSearchPath("include/agora_rtc_engine")
            ]
        ),
        .binaryTarget(
            name: "AgoraRtcWrapper",
            url: "https://download.agora.io/sdk/release/AgoraIrisRTC_iOS-4.5.3-build.1.zip",
            checksum: "0ec17b1658d4f149e962f16d88c23f71b97319416e6e136bf32e7a12b7bdc352"
        )
    ]
)
