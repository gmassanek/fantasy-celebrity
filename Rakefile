# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path("../config/application", __FILE__)

Rails.application.load_tasks

if %w(development test).include?(Rails.env)
  require "rubocop/rake_task"
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.options = ["--display-cop-names"]
  end

  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:rspec)

  require "cucumber/rake/task"
  Cucumber::Rake::Task.new(:cucumber) do |t|
    t.cucumber_opts = "features --format pretty"
  end

  task(:audit_dependencies) do
    system("bundle-audit") || exit
  end

  task({ test: %w(rspec ui:build cucumber rubocop audit_dependencies) })
end
