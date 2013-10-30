require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @question = questions(:one)
  end
end
