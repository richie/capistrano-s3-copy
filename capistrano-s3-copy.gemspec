# -*- encoding: utf-8 -*-
require File.expand_path('../lib/capistrano-s3-copy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Richie McMahon"]
  gem.email         = ["richie.mcmahon@gmail.com"]
  gem.description   = %q{Capistrano deployment strategy that creates and pushes a tarball 
into S3, for both pushed deployments and pulled auto-scaling.}
  gem.summary       = %q{Capistrano deployment strategy that transfers the release on S3}
  gem.homepage      = "http://github.com/richie/capistrano-s3-copy"
  gem.add_dependency 'capistrano', ">= 2.12.0"
  gem.add_dependency 's3sync'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "capistrano-s3-copy"
  gem.require_paths = ["lib"]
  gem.version       = Capistrano::S3::Copy::VERSION
end
