Pod::Spec.new do |s|
  s.name             = "ChipmunkSwiftWrapper"
  s.version          = "0.1.0"
  s.summary          = "Convenience wrapper for chipmunk physics written in Swift 2"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  # s.description      = <<-DESC
  #                      DESC

  s.homepage         = "https://github.com/jakubknejzlik/ChipmunkSwiftWrapper"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "jakubknejzlik" => "jakub.knejzlik@gmail.com" }
  s.source           = { :git => "https://github.com/jakubknejzlik/ChipmunkSwiftWrapper.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ChipmunkSwiftWrapper' => ['Pod/Assets/*.png']
  }

  s.platform :ios, '8.0'
  s.platform :tvos, '9.0'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
