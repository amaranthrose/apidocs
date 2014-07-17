#Configure Rails Environment
ENV["RAILS_ENV"] = "test"
    require File.expand_path("../dummy/config/environment.rb",  __FILE__)

    require 'rspec/rails'
    require 'capybara/rspec'
    require 'rspec/autorun'
 
    ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

    # Requires supporting ruby files with custom matchers and macros, etc,
    # in spec/support/ and its subdirectories.
    Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

    RSpec.configure do |config|
      config.use_transactional_fixtures = true
      config.include Capybara::DSL, :example_group => { :file_path => /\bspec\/integration\// }
      config.include Apidocs::Engine.routes.url_helpers
      config.infer_spec_type_from_file_location!
   end
