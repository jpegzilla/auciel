# frozen_string_literal: true

desc 'install dependencies'
task :install do
  puts
  puts 'installing dependencies...'
  system 'bundle install'
end

desc 'check dependencies'
task :check_deps do
  puts
  puts 'checking dependencies...'
  result = system 'bundle check'

  system('rake install') unless result == true
end

desc 'start server'
task start: [:check_deps] do
  puts
  puts 'starting server...'
  system 'ruby main.rb'
end

desc 'start server in development mode (with nodemon)'
task dev: [:check_deps] do
  puts
  puts 'starting server in development mode...'
  puts
  system 'nodemon main.rb --development'
end

desc 'package gem'
task pack: [:check_deps] do
  puts
  puts 'building gem...'
  puts
  system 'gem build auciel.gemspec'
end
