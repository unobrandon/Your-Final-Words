# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!
target 'FinalWordsChat' do
    # Pods for testing
    pod 'Firebase'
    pod 'FirebaseAuth'
    pod 'FirebaseDatabase'
    pod 'FirebaseStorage'
    pod 'Firebase/Core'
    pod 'Firebase/Messaging'
    pod 'Firebase/Crash'
    pod 'Firebase/Performance'
    pod 'Hero'
    pod 'JSQMessagesViewController'

end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "11.0"
		end
	end
end
