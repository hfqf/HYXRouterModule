#
# Be sure to run `pod lib lint HYXRouterModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HYXRouterModule'
  s.version          = '0.8.0'
  s.summary          = 'huiyinxun.com内部使用的基于MGJRouter扩展的iOS路由组件'
  s.description      = '特性:1.根据命名规则自动注册module \
                            2.提供UIModule和ServiceModule两个打开方案 \
                            3.提供拦截器功能，比如登录 \
                            4.使用链式调用,参考js的promise，每次可返回成功或失败的回调信息\
                            5.传值时可以携带各种类型参数'

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
