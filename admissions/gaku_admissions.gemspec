# encoding: UTF-8
version = File.read(File.expand_path("../../GAKU_ENGINE_VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'gaku_admissions'
  s.version      = version
  s.summary      = 'Admission management for GAKU Engine'
  s.description  = 'Required dependency for GAKU Engine'
  s.required_ruby_version = '>= 2.0.0'

  s.authors      = ['Vassil Kalkov']
  s.email        = 'info@genshin.org'
  s.homepage     = 'http://github.com/Genshin/GAKUEngine'

  s.files        = Dir['LICENSE', 'README.md', 'app/**/*', 'config/**/*', 'lib/**/*', 'db/**/*', 'vendor/**/*']
  s.test_files   = `git ls-files -- {spec}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'
  s.add_dependency 'gaku_core', version
  s.add_dependency 'deface'
end
