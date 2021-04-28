#
# Be sure to run `pod lib lint HitPaySDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HitPaySDK'
  s.version          = '1.0.1'
  s.summary          = 'A subclass on UILabel that provides a blink.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A complete description of HitPaySDK to payment'     
  s.homepage         = 'https://github.com/nvngoc2409'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nvngoc2409' => 'ninhngoc.t4.bkdn@gmail.com' }
  s.source       = { :git => "https://github.com/kevinrandrup/DropDownMenu.git", :tag => s.version }
  s.source_files  = 'Classes/*.{h,m,swift}'
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.swift_version = "5.4"
  
  # s.resource_bundles = {
  #   'HitPaySDK' => ['HitPaySDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
