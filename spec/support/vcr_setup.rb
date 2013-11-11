require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes' # Cassettes directory
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
