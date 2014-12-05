# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Maintain your gem's version:
require "moj_template/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "moj_template"
  s.version     = MojTemplate::VERSION
  s.authors     = ["Dom Smith"]
  s.email       = ["dom.smith@digital.justice.gov.uk"]
  s.homepage    = "https://github.com/ministryofjustice/moj_template"
  s.summary     = "MOJ DS Template"
  s.description = "Basic template for MOJ Services"
  s.license     = "MIT"

  s.files          = Dir["{app,lib}/**/*"] + ["LICENCE.txt", "README.md"]
  s.require_paths  = ["lib"]

  s.add_dependency 'rails', '>= 3.1'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'sprockets', '2.10.0'
  s.add_development_dependency 'sass', '3.2.9'
  s.add_development_dependency 'govuk_template', '0.11.0'
  s.add_development_dependency 'govuk_frontend_toolkit', '3.1.0'
  s.add_development_dependency 'gem_publisher', '1.3.1'
  s.add_development_dependency 'rspec', '2.14.1'
end
