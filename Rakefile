require 'rake/testtask'

task default: "test"

Rake::TestTask.new do |task|
  task.pattern = 'test/*_test.rb'
end

desc "Play the game!"
task :run do
  exec './bin/war_paint'
end

desc "Generate project documentation"
task :doc do
  exec 'yard doc'
end
