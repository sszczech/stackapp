# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

require 'requests/helpers'

Capybara.default_driver = :selenium
DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.include Helpers, :type => :request
  config.include FactoryGirl::Syntax::Methods

  config.before(:each) {
    DatabaseCleaner.clean
  }

  config.mock_with :rspec

  config.infer_base_class_for_anonymous_controllers = false
end
