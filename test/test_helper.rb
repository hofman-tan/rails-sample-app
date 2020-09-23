ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # !! I've uncommented this to avoid database locking when testing db models !!
  #parallelize(workers: :number_of_processors, with: :threads)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # use ApplicationHelper in testing
  include ApplicationHelper

  # Add more helper methods to be used by all tests here...
end
