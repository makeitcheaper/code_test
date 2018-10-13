# frozen_string_literal: true

require 'webmock/rspec'
require 'httparty'
require 'action_controller'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  
  require 'dotenv'
  Dotenv.load('.env')

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups

  Dir['./spec/support/shared_context/*.rb'].each { |f| require f }
end
