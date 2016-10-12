ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

task :console => :environment do
  Pry.start
end

task :environment do
  require_relative 'config/environment'
end