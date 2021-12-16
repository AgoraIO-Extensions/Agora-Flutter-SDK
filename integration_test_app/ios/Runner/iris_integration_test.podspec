#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint agora_rtc_engine.podspec` to validate before publishing.
#

Pod::Spec.new do |s|
  s.name             = 'iris_integration_test'
  s.version          = '3.3.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = 'project.description'
  s.homepage         = 'https://github.com/AgoraIO/Flutter-SDK'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Agora' => 'developer@agora.io' }
  s.source           = { :path => '.' }
  s.vendored_frameworks = 'iris_integration_test.framework'
  s.platform = :ios, '9.0'
end
