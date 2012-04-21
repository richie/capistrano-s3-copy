#!/usr/bin/env rake
require 'rdoc/task'
require "bundler/gem_tasks"

desc "Build the RDoc API documentation"
RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = "doc"
  rdoc.title    = "Capistrano S3 Copy"
  rdoc.options += %w(--main README)
  rdoc.rdoc_files.include('README.md', 'LICENSE', 'lib/**/*.rb')
end

desc "Build documentation"
task :doc => [ :rdoc ]

desc "Clean up generated directories and files"
task :clean do
  rm_rf "pkg"
  rm_rf "doc"
end