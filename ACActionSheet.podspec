
Pod::Spec.new do |s|
  s.name             = 'ACActionSheet'
  s.version          = '1.0.4'
  s.summary          = 'An easy way to use actionSheet/alertView'

  s.homepage         = 'https://github.com/GardenerYun'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '章子云' => 'gardeneryun@foxmail.com' }
  s.source           = { :git => 'https://github.com/GardenerYun/ACActionSheet.git', :tag => s.version}

  s.ios.deployment_target = '8.0'

  s.source_files 	= 'ACActionSheet/**/*.{h,m}'
  s.resource 		= 'ACActionSheet/ACActionSheet.bundle'
  s.requires_arc 	= true
  s.frameworks 		= 'UIKit', 'Foundation'

end
