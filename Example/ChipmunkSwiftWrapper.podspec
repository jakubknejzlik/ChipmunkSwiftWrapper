Pod::Spec.new do |s|
s.name = 'ChipmunkSwiftWrapper'
s.version = '0.1.0'
s.license = { :type => 'MIT', :file => 'LICENSE' }
s.summary = 'Convenience wrapper for chipmunk physics written in Swift 2'

s.homepage = 'https://github.com/jakubknejzlik/ChipmunkSwiftWrapper'
s.author = { 'jakubknejzlik' => 'jakub.knejzlik@gmail.com' }
#s.social_media_url = 'http://twitter.com/john.doe'

s.source = { :git => 'https://github.com/jakubknejzlik/ChipmunkSwiftWrapper.git', :tag => String(s.version) }
s.source_files = 'Pod/**/*.{swift,h,c}'
s.ios.deployment_target = '8.0'
s.tvos.deployment_target = '9.0'
s.osx.deployment_target = '10.10'
end
