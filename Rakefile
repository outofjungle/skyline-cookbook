require 'rspec/core/rake_task'
require 'rake/clean'

test_results_dir = ENV['TEST_RESULTS_DIR'] || 'test_results'

CLEAN.include('vendor/cookbooks/skyline/*')
CLOBBER.include(test_results_dir)

directory test_results_dir

specfiles = 'spec/**/*_spec.rb'

RSpec::Core::RakeTask.new(:spec) do | task |
  task.pattern = specfiles
  task.rspec_opts = "--format documentation --format RspecJunitFormatter --out #{test_results_dir}/results.xml --require spec_helper"
end

task :default => [:clean, :clobber, :spec]

task :test => [:clean, :clobber, :spec]
