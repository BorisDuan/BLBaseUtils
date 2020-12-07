#
# Be sure to run `pod lib lint BLBaseUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BLBaseUtils'
  s.version          = '0.0.1'
  s.summary          = '彼恋基础组件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  彼恋基础组件，包含网络封装、本地数据封装、常量定义等等
                       DESC

  s.homepage         = 'https://github.com/BorisDuan/BLBaseUtils'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BorisDuan' => '782985735@qq.com' }
  s.source           = { :git => 'https://github.com/BorisDuan/BLBaseUtils.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_versions = ['5.0']
#  s.source_files = 'BLBaseUtils/Classes/**/*'
  
  s.subspec 'Extension' do |ss|
      ss.source_files = 'BLBaseUtils/Classes/Extension/*.{swift}'
  end
  s.subspec 'HttpRequest' do |ss|
      ss.source_files = 'BLBaseUtils/Classes/HttpRequest/*.{swift}'
  end
  s.subspec 'Assets' do |ss|
      ss.source_files = 'BLBaseUtils/Assets/*.{swift}'
  end
#  s.subspec 'FindPassword' do |ss|
#      ss.source_files = 'BLSignSDK/Classes/FindPassword/*.{swift}'
#  end
  
  
  # s.resource_bundles = {
  #   'BLBaseUtils' => ['BLBaseUtils/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'Foundation'
   s.dependency 'SwiftyJSON'
   s.dependency 'Alamofire'
end
