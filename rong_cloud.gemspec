Gem::Specification.new do |s|
  s.name         = 'rong_cloud_server'
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.summary      = 'RongCloud Server API SDK'
  s.description  = 'RongCloud Server API in Ruby，http://www.rongcloud.cn/docs/server.html'
  s.version      = '0.2.1'
  s.files        = `git ls-files`.split("\n")
  s.authors      = ['Martin Hong']
  s.email        = 'hongzeqin@gmail.com'
  s.homepage     = 'http://blog.hackerpie.com/rong_cloud/'
  s.license      = 'MIT'

  s.add_development_dependency 'minitest', '>= 3'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'coveralls'
end
