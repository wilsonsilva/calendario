require_relative 'lib/calendario/version'

Gem::Specification.new do |spec|
  spec.name          = 'calendario'
  spec.version       = Calendario::VERSION
  spec.authors       = ['Wilson Silva']
  spec.email         = ['me@wilsonsilva.net']

  spec.summary       = 'A cal-like calendar'
  spec.description   = 'A cal-like calendar'
  spec.homepage      = 'https://github.com/wilsonsilva/calendario'
  spec.license       = 'MIT'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/wilsonsilva/calendario'
  spec.metadata['changelog_uri']   = 'https://github.com/wilsonsilva/calendario/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler-audit', '~> 0.7'
  spec.add_development_dependency 'guard', '~> 2.16'
  spec.add_development_dependency 'guard-bundler', '~> 3.0'
  spec.add_development_dependency 'guard-bundler-audit', '~> 0.1'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'guard-rubocop', '~> 1.3'
  spec.add_development_dependency 'memoria', '~> 0.1'
  spec.add_development_dependency 'overcommit', '~> 0.53'
  spec.add_development_dependency 'pry', '~> 0.13'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.85'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.40'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
  spec.add_development_dependency 'simplecov-console', '~> 0.7'
  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_development_dependency 'yard-junk', '~> 0.0.7'
  spec.add_development_dependency 'yardstick', '~> 0.9'
end
