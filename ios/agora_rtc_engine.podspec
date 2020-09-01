require "yaml"
require "ostruct"
project = OpenStruct.new YAML.load_file("../pubspec.yaml")

Pod::Spec.new do |s|
  s.name             = project.name
  s.version          = project.version
  s.summary          = 'Agora.io offical flutter sdk plugin.'
  s.description      = project.description
  s.homepage         = 'https://github.com/agoraio/flutter-sdk'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Agora' => 'developer@agora.io' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.dependency 'AgoraRtcEngine_iOS_Crypto', '2.9.3'
  s.static_framework = true

  s.ios.deployment_target = '8.0'
end
