#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint agora_rtc_engine.podspec` to validate before publishing.
#
require "yaml"
require "ostruct"
project = OpenStruct.new YAML.load_file("../pubspec.yaml")

Pod::Spec.new do |s|
  s.name             = project.name
  s.version          = project.version
  s.summary          = 'A new flutter plugin project.'
  s.description      = project.description
  s.homepage         = 'https://github.com/AgoraIO/Flutter-SDK'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Agora' => 'developer@agora.io' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*.{h,mm,m,swift}'
  s.dependency 'Flutter'

  # native dependencies start
  s.dependency 'AgoraAudio_Special_iOS', '3.7.3.5'
  # native dependencies end

  # iris dependencies start
  s.dependency 'AgoraIrisRTC_iOS', '3.7.3.5'
  # iris dependencies end
#   s.dependency 'AgoraRtcWrapper'
  s.platform = :ios, '13.0'
  s.swift_version = '5.0'
  s.libraries = 'stdc++'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
