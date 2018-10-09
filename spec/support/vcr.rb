# frozen_string_literal: true

VCR.configure do |config|
  config.ignore_hosts 'mic-leads.dev-test.makeiteasy.com'
  config.cassette_library_dir = 'spec/fixtures/cassettes'
  config.hook_into :webmock
end
