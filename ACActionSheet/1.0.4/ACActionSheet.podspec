#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#


Pod::Spec.new do |s|
  s.name             = 'ACActionSheet'
  s.version          = '1.0.4'
  s.summary          = 'ACActionSheet Tool'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
				ACActionSheet Tool
                       DESC

  s.homepage         = 'https://github.com/GardenerYun'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '章子云' => 'gardeneryun@foxmail.com' }
  s.source           = { :git => 'https://github.com/GardenerYun/ACActionSheet.git', :tag => s.version}


  s.ios.deployment_target = '8.0'

  s.source_files = 'ACActionSheet/*.{h,m}'
  
  s.resource_bundles = {
    'ACActionSheet' => ['ACActionSheet/*.{png,bundle}']
  }

  s.requires_arc = true
  s.frameworks = 'UIKit', 'Foundation'

end
