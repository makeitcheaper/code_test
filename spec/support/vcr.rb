# frozen_string_literal: true

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('ABCDEFG') { ENV.fetch('LEAD_API_ACCESS_TOKEN') }
end
