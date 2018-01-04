lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'early'

Gem::Specification.new do |spec|
  spec.name          = 'early'
  spec.version       = Early::VERSION
  spec.authors       = ['Genadi Samokovarov']
  spec.email         = ['gsamokovarov@gmail.com']

  spec.summary       = 'Checks for environment variables early in your program.'
  spec.description   = 'Checks for environment variables early in your program.'
  spec.homepage      = 'https://github.com/gsamokovarov/early'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
