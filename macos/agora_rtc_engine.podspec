#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint agora_rtc_ng.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'agora_rtc_engine'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*.{h,mm}', 'Classes/File.swift'
  s.dependency 'FlutterMacOS'

  plugin_dev_path = File.join(File.dirname(File.realpath(__FILE__)), '.plugin_dev')
  if File.exist?(plugin_dev_path)
    puts '[plugin_dev] Found .plugin_dev file, use vendored_frameworks instead.'
    s.vendored_frameworks = 'libs/*.xcframework', 'libs/*.framework'
  else
  s.dependency 'AgoraRtcEngine_macOS', '4.3.2'
  s.dependency 'AgoraIrisRTC_macOS', '4.3.2-build.1'
  end

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end