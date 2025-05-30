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
  s.frameworks = ['AVFoundation', 'AVKit']
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework AVFoundation -framework AVKit' }

  plugin_dev_path = File.join(File.dirname(File.realpath(__FILE__)), '.plugin_dev')
  if File.exist?(plugin_dev_path)
    puts '[plugin_dev] Found .plugin_dev file, use vendored_frameworks instead.'
    s.vendored_frameworks = 'libs/*.xcframework'
  else
    # iris dependencies start
    s.dependency 'AgoraIrisRTC_iOS', '4.3.2.16-build.1'
    # iris dependencies end

    # native dependencies start
    s.dependency 'AgoraRtcEngine_Special_iOS', '4.3.2.245'
    # native dependencies end

    s.dependency 'AgoraPIP_iOS', '0.0.2-rc.2'
  end
  
  s.platform = :ios, '9.0'
  s.swift_version = '5.0'
  s.libraries = 'stdc++'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end