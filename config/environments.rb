require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require 'dotenv'

Time.zone = "Tokyo"
ActiveRecord::Base.default_timezone = :local

Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

env_index = ARGV.index("-e")
env_arg = ARGV[env_index + 1] if env_index
env = env_arg || ENV["RACK_ENV"] || "development"

Dotenv.load(".env.#{env}")

use ActiveRecord::ConnectionAdapters::ConnectionManagement # close connection to the DDBB properly...https://github.com/puma/puma/issues/59
databases = YAML.load_file("config/database.yml")
ActiveRecord::Base.establish_connection(databases[env])
