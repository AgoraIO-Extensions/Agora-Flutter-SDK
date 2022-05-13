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
  s.source_files = 'Classes/**/*.{h,mm}', 'Classes/File.swift'
  s.dependency 'FlutterMacOS'
  s.dependency 'AgoraIrisRTC_macOS', '3.6.2-fix.2'
  s.platform = :osx, '10.11'
end
