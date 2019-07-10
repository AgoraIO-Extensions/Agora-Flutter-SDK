Pod::Spec.new do |s|
  s.name             = 'agora_rtc_engine'
  s.version          = '2.4.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://docs.agora.io'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Agora' => 'developer@agora.io' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.dependency 'AgoraRtcEngine_iOS_Crypto', '2.8.0'
  s.static_framework = true

  s.ios.deployment_target = '8.0'
end
