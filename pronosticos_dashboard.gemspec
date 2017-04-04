# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pronosticos_dashboard/version'

Gem::Specification.new do |spec|
  spec.name          = 'pronosticos_dashboard'
  spec.version       = PronosticosDashboard::VERSION
  spec.authors       = ['chischaschos']
  spec.email         = ['larin.s931@gmail.com']
  spec.summary       = %q{Render interesting graphs from a spreadsheet with sales}
  spec.homepage      = 'https://github.com/chischaschos/pronosticos_dashboard'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '~> 4.1.4'
  spec.add_dependency 'dotenv'
  spec.add_dependency 'pg'
  spec.add_dependency 'google_drive'
  spec.add_dependency 'haml'
  spec.add_dependency 'sinatra'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'capybara-webkit'
  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'fabrication'
  spec.add_development_dependency 'foreman'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'shotgun'
end
