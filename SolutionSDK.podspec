#
# Be sure to run `pod lib lint SolutionSDK.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'SolutionSDK'
  s.version          = '1.5.0-alpha.4'
  s.summary          = 'Identity risk solution H5 module.'
  s.description      = 'Identity risk solution H5 module.'

  s.homepage         = 'https://www.advance.ai'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'advance.ai' => 'advance.ai.mobile@advancegroup.com' }
  s.source = { :git => 'https://github.com/advance-ai-mobile/SolutionSDK.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.vendored_frameworks = ['Frameworks/*.xcframework']

  # Dependencies (auto-synced from SolutionSDK.podspec)
  s.dependency 'AAIDataVisorSDK', '0.1.8'
  s.dependency 'AAICore', '~> 1.0.1'

end
