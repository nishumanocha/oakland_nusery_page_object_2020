require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.profile = 'default'
end


Cucumber::Rake::Task.new(:all_smoke_tests) do |t|
  t.profile = 'smoke'
end

Cucumber::Rake::Task.new(:sanity) do |t|
  t.profile = 'sanity'
end

task :default => :features
task :smoke_and_sanity => [:smoke,:sanity]
