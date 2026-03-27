#
# Be sure to run `pod lib lint LivenessProSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SolutionSDK'
  s.version          = '1.5.0-alpha.4'
  s.summary          = 'Identity risk solution H5 module.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Identity risk solution H5 module.'

  s.homepage         = 'https://www.advance.ai'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'advance.ai' => 'advance.ai.mobile@advancegroup.com' }
  s.source = { :git => 'https://github.com/advance-ai-mobile/SolutionSDK.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.vendored_frameworks = ['Frameworks/*.xcframework']

  # Dependencies (auto-synced from SolutionSDK.podspec)
  s.dependency 'AAIDataVisorSDK', '0.1.8'
  s.dependency 'AAICore', '~> 1.0.1'

  # Dependencies (auto-synced from SolutionSDK.podspec)
  
end
