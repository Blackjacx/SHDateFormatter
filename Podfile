platform :ios, '8.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

target 'SHDateFormatter' do

  target 'SHDateFormatterTests' do
    pod 'Quick'
    pod 'Nimble'
  end
end

post_install do |options|

    options.pods_project.build_configurations.each do |config|
        if config.name == "Release"
            config.build_settings['SWIFT_COMPILATION_MODE'] = 'Whole Module'
            else
            config.build_settings['SWIFT_COMPILATION_MODE'] = 'Incremental'
        end
    end
end
