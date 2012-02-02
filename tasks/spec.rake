desc "Run specs"
RSpec::Core::RakeTask.new 'spec'

namespace :spec do
  desc 'Run Coverage'
  task :cov do
    require 'simplecov'

    SimpleCov.adapters.define 'gem' do
      add_filter '/spec/'
      add_filter '/config/'
      add_filter '/.bundle/'

      add_group 'Models', 'lib/'
    end

    SimpleCov.start 'gem'

    SimpleCov.at_exit do
      SimpleCov.result.format!
      puts "Code coverage: #{SimpleCov.result.covered_percent.round(2)}%"
    end

    Rake::Task['spec'].invoke
  end
end
