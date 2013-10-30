require 'test_helper'

class SubQuestionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @sub_question = sub_questions(:one)
  end
end
