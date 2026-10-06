Pod::Spec.new do |s|
  s.name = 'RevdokuAPI'
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.13'
  s.tvos.deployment_target = '11.0'
  s.watchos.deployment_target = '4.0'
  s.version = '2.0.0'
  s.source = { :git => 'https://github.com/revdoku/revdoku-swift.git', :tag => 'v2.0.0' }
  s.authors = 'Revdoku'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage = 'https://revdoku.com'
  s.summary = 'RevdokuAPI Swift SDK'
  s.source_files = 'RevdokuAPI/Classes/**/*.swift'
  s.dependency 'AnyCodable-FlightSchool', '~> 0.6'
end
