# frozen_string_literal: true

require_relative 'lib/rails_react_errors/version'

Gem::Specification.new do |spec|
  spec.name = 'rails_react_errors'
  spec.version = RailsReactErrors::VERSION
  spec.authors = ['Manish0407']
  spec.email = ['manish.prajapati0492@gmail.com']

  spec.summary       = 'Consistent error responses for Rails APIs used by React frontends'
  spec.description   = 'rails_react_errors standardizes validation and API error responses in a React-friendly JSON format.'
  spec.homepage      = 'https://github.com/Manish0407/rails_react_errors'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['homepage_uri'] = 'https://github.com/Manish0407/rails_react_errors'
  spec.metadata['source_code_uri'] = 'https://github.com/Manish0407/rails_react_errors'
  spec.metadata['changelog_uri'] = 'https://github.com/Manish0407/rails_react_errors/blob/main/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .rubocop.yml])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'activemodel', '>= 6.0'

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
