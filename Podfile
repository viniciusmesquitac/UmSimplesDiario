# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'UmSimplesDiario' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for UmSimplesDiario
    pod 'SnapKit', '~> 5.0.0'
    pod 'RxSwift', '5.1.0'
    pod 'RxCocoa', '5.1.0'
    pod 'RxDataSources', '~> 4.0'
    pod 'RxGesture'
    pod 'SwiftLint'
    pod 'UITextView+Placeholder'

  target 'UmSimplesDiarioTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'UmSimplesDiarioUITests' do
    # Pods for testing
  end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
        end
    end
end

