#!/usr/bin/env rake
require "bundler/gem_tasks"
 require 'rake/testtask'
 
Rake::TestTask.new do |t|
  t.libs << 'lib/osx_clean_app_delete'
  t.test_files = FileList['test/lib/osx_clean_app_delete/*_test.rb']
  t.verbose = true
end
 
task :default => :test