# github 公开源
source 'https://github.com/CocoaPods/Specs.git'

# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

use_frameworks!
inhibit_all_warnings!

target 'Assureapt' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Assureapt
  ## RX
  pod 'RxSwift', '5.0.0'
  pod 'RxCocoa', '5.0.0'
  pod 'RxDataSources', '4.0.0'
  pod 'ReusableKit', '3.0.0'
  pod 'ReusableKit/RxSwift'
  pod 'RxGesture', '3.0.1'
  ## common
  pod 'SwiftyJSON', '5.0.0'
  pod 'HandyJSON', '5.0.1'
  pod 'SnapKit', '4.2.0'
  pod 'Then', '2.6.0'
  ## network
  pod 'Alamofire', :git=>'https://github.com/Alamofire/Alamofire.git', :tag=>'4.9.1'
  pod 'Moya', :git=>'https://github.com/Moya/Moya.git', :tag=>'14.0.0-alpha.1'
  pod 'Moya/RxSwift', :git=>'https://github.com/Moya/Moya.git', :tag=>'14.0.0-alpha.1'
  ## tool
  pod 'IQKeyboardManagerSwift', '6.5.4'
  pod 'Timepiece', '1.3.1' #date处理
  pod 'PKHUD', '5.3.0' #提示框
  pod 'SwiftLint', '0.37.0' #代码规范检测
  pod 'GDPerformanceView-Swift', '2.0.3' #app性能监测
  pod 'EmptyDataSet-Swift', '5.0.0' #tableView无数据显示
  pod 'Kingfisher', '4.10.1' #图片加载
  pod 'PullToRefresher', '3.2' #下拉刷新和上拉加载
  
  ## oc tool
  pod 'SSZipArchive', '2.2.2'
  pod 'YYModel', '1.0.4'
  pod 'SVProgressHUD', '2.2.5'
  #firebase 用于推送
  pod 'Firebase/Core', '5.5.0'
  pod 'Firebase/Messaging'
  
  
  ## 测试环境rxswift资源释放检测
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          # rxswift
          if target.name == 'RxSwift'
            target.build_configurations.each do |config|
              if config.name == 'Debug'
                config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
              end
            end
          end
      end
  end
  
  target 'AssureaptTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'AssureaptUITests' do
    # Pods for testing
  end

end
