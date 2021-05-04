#
# Be sure to run `pod lib lint HitPaySDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'HitPaySDK'
    s.version          = '1.0.8'
    s.summary          = 'A subclass on UILabel that provides a blink.'
    s.description      = 'A complete description of HitPaySDK to payment'
    s.homepage         = 'https://github.com/nvngoc2409'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'nvngoc2409' => 'ninhngoc.t4.bkdn@gmail.com' }
    s.source       = { :git => 'https://github.com/nvngoc2409/HitPaySDK.git', :tag => s.version }
    s.requires_arc = true
    s.source_files = 'HitPaySDK/**/**'
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    s.ios.deployment_target = '13.0'
    s.swift_version = "4.0"
#    s.resources = 'HitPaySDK/**/*'
#    s.resource_bundles = {
#        'HitPaySDK' => ['HitPaySDK/**/*', 'HitPaySDK/**/*/*']
#    }
#    s.resource_bundle = { 'HitPaySDK' => 'HitPaySDK/Assets/Resource.bundle/*.xcassets' }
    s.static_framework = true
    s.dependency 'Alamofire'
    s.dependency 'SwiftyJSON'
    s.dependency 'CardIO'
    s.dependency 'Stripe'
    s.dependency 'Spring'
    s.dependency 'MBProgressHUD'
    s.dependency 'KeychainSwift'
end
