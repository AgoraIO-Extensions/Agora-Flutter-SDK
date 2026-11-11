#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint agora_rtc_engine.podspec` to validate before publishing.
#
require "yaml"
require "ostruct"
project = OpenStruct.new YAML.load_file("../pubspec.yaml")

# Agora iOS SDK distributed through the Agora CDN.
#
# The iOS integration is CDN based: `prepare_command` downloads the native SDK
# and the Iris wrapper and vendors their xcframeworks, so the plugin does not
# depend on the `AgoraRtcEngine_Special_iOS` / `AgoraIrisRTC_iOS` CocoaPods pods.
# Keep these values in sync with `agora_rtc_engine/Package.swift`.
agora_ios_sdk_version = '4.6.4.2'
agora_ios_sdk_url = "https://download.agora.io/sdk/release/AgoraRtcEngine_Special_iOS-#{agora_ios_sdk_version}.zip"
agora_ios_sdk_sha256 = '37bc083fa98d928ed80b395c6e1e3fd8a26f780ddbb451d495a1bc6b728c3b57'
agora_ios_iris_version = '4.6.4.2-build.1'
agora_ios_iris_url = "https://download.agora.io/sdk/release/AgoraIrisRTC_iOS-#{agora_ios_iris_version}.zip"
agora_ios_iris_sha256 = 'a2acafd2b1a0a6038b42e6e8e4d1e719ceeb3367deab5fb3bca57d1ceaf58b9c'
agora_ios_weak_frameworks = %w[
  AgoraAiEchoCancellationExtension
  AgoraAiEchoCancellationLLExtension
  AgoraAiNoiseSuppressionExtension
  AgoraAiNoiseSuppressionLLExtension
  AgoraAudioBeautyExtension
  AgoraClearVisionExtension
  AgoraContentInspectExtension
  AgoraFaceCaptureExtension
  AgoraFaceDetectionExtension
  AgoraLipSyncExtension
  AgoraReplayKitExtension
  AgoraRtcKit
  AgoraSoundTouch
  AgoraSpatialAudioExtension
  AgoraVideoAv1EncoderExtension
  AgoraVideoEncoderExtension
  AgoraVideoQualityAnalyzerExtension
  AgoraVideoSegmentationExtension
  Agorafdkaac
  Agoraffmpeg
  aosl
  video_dec
]

Pod::Spec.new do |s|
  s.name             = project.name
  s.version          = project.version
  s.summary          = 'A new flutter plugin project.'
  s.description      = project.description
  s.homepage         = 'https://github.com/AgoraIO/Flutter-SDK'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Agora' => 'developer@agora.io' }
  s.source           = { :path => '.' }
  s.source_files = 'agora_rtc_engine/Sources/**/*.{h,mm,m,swift}'
  s.dependency 'Flutter'

  plugin_dev_path = File.join(File.dirname(File.realpath(__FILE__)), '.plugin_dev')
  if File.exist?(plugin_dev_path)
    puts '[plugin_dev] Found .plugin_dev file, use vendored_frameworks instead.'
    s.vendored_frameworks = 'libs/*.xcframework', 'libs/*.framework'
    s.dependency 'AgoraRtcEngine_iOS', '4.6.0'
  else
    # cdn dependencies start
    s.prepare_command = <<-CMD
      bash ./scripts/download_ios_sdk.sh \\
        --native-url "#{agora_ios_sdk_url}" \\
        --native-sha256 "#{agora_ios_sdk_sha256}" \\
        --iris-url "#{agora_ios_iris_url}" \\
        --iris-sha256 "#{agora_ios_iris_sha256}" \\
        --dest ./libs
    CMD

    s.vendored_frameworks = 'libs/*.xcframework'
    s.weak_frameworks = agora_ios_weak_frameworks
    # cdn dependencies end
  end

  s.platform = :ios, '9.0'
  s.swift_version = '5.0'
  s.libraries = 'stdc++'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
