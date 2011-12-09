require "bundler"
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
require 'rspec/core/version'

Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |rake| load rake }

task :default => :spec
