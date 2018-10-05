lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tx_translate/version'

Gem::Specification.new do |spec|
  spec.name          = 'tx_translate'
  spec.version       = TxTranslate::VERSION
  spec.authors       = ['xdite']
  spec.email         = ['xdite@otcbtc.com']

  spec.summary       = 'Quick Gitbook Generator '
  spec.description   = 'Quick Gitbook Generator '
  spec.homepage      = 'https://github.com/xdite/tx_translate'
  spec.license       = 'MIT'
  spec.executables << 'tx_translate'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'httparty'
  spec.add_dependency 'json'
  spec.add_dependency 'thor'
  spec.add_dependency 'typhoeus'
end
