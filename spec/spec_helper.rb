require 'iugu'
require 'vcr'
require 'byebug'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!

  # needed to write new specs without having to delete cassettes
  config.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:each) do
    Iugu.api_key = 'development_api_token'
    allow(Iugu).to receive(:base_uri).and_return('http://api.iugu.dev/v1/')
  end
end
