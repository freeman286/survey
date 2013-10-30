require 'test_helper'

class SegmentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @segment = segments(:one)
  end
end
