# bundle exec rerun -- rackup config.ru
require "./lib/mihari"

# set rack env as development
ENV["RACK_ENV"] ||= "development"

run Mihari::App
