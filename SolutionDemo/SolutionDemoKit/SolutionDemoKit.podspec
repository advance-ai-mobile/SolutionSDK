Pod::Spec.new do |s|
  s.name             = 'SolutionDemoKit'
  s.version          = '0.1.0'
  s.summary          = 'Source files for SolutionDemo app.'
  s.homepage         = 'https://www.advance.ai'
  s.license          = { :type => 'MIT' }
  s.author           = { 'advance.ai' => 'advance.ai.mobile@advancegroup.com' }
  s.source           = { :git => '', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'Sources/**/*.swift'

  s.dependency 'SolutionSDK'
  s.dependency 'SnapKit'
end
