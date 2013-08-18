Pod::Spec.new do |s|
  s.name     = 'TravisCIWrapper'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = 'An Objective-C Travis-CI Wrapper'
  s.author   = { 'adsantos' => 'adrianasucena@gmail.com' }
  s.homepage = 'https://github.com/adsantos/TravisCIWrapper'
  s.source   = { :git => 'https://github.com/adsantos/TravisWrapper.git' }
  s.description = 'An Objective-C Travis-CI Wrapper.'
  s.platform = :ios
  s.source_files = 'TravisCIWrapper/Framework/**/*.{h,m}'
  s.dependency 'AFNetworking', '~> 0.10.0'
  s.framework = 'SystemConfiguration'
  s.requires_arc = true

end
