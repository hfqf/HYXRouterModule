#
# Be sure to run `pod lib lint HYXRouterModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HYXRouterModule'
  s.version          = '0.6.0'
  s.summary          = 'A short description of HYXRouterModule.'
  s.description      = 'HYXRouterModule HYXRouterModule HYXRouterModule'

  s.homepage         = 'https://gitee.com/hfqf123/HYXRouterModule'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Points' => 'hfqf123@126.com' }
  s.source           = { :git => 'https://gitee.com/hfqf123/HYXRouterModule.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'HYXRouterModule/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HYXRouterModule' => ['HYXRouterModule/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'MGJRouter', '~> 0.10.0'

end
