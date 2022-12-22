# This file is used by Rack-based servers to start the application.

require_relative "config/environment"
map '/docs' do
  run Rack::Directory.new('public/swagger/public')
end
run Rails.application
Rails.application.load_server
