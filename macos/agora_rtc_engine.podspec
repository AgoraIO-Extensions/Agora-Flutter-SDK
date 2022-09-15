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
  # s.dependency 'AgoraRtcWrapper'
  s.dependency 'AgoraRtcEngine_Special_macOS', '4.0.0.5'
  s.dependency 'AgoraIrisRTC_macOS', '4.0.0-rc.2'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end
