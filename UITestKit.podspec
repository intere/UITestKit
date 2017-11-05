#
# Be sure to run `pod lib lint UITestKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UITestKit'
  s.version          = '0.1.0'
  s.summary          = 'Programmatic UI Tests (not using the Apple UI Test Framework).  XCTest-based tests.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This library solves the problem of having to maintain Apple's UI Tests, but lets you automate UI Tests for
integration testing.  By using this library, you are no longer subject to the limitations of the UI Tests
that Apple provides a framework for.  You can run UI Tests as part of a normal Unit Test target.  The strategy
is similar to many other language UI Testing frameworks, timers and conditional checks.  See the example project
to see how it starts you off.

I wrote this library, because it's the basic building blocks that I've used in so many iOS projects now.
I've had issues with the Apple UI Test framework and it's time to apply the DRY (Don't Repeat Yourself)
principle.
                       DESC

  s.homepage         = 'https://github.com/intere/UITestKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Eric Internicola' => 'intere@gmail.com' }
  s.source           = { :git => 'https://github.com/intere/UITestKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/intere'

  s.ios.deployment_target = '9.3'

  s.source_files = 'UITestKit/**/*'

  # s.resource_bundles = {
  #   'UITestKit' => ['UITestKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.frameworks = 'XCTest'

end
