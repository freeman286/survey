require 'test_helper'

class UserAnswerTest < ActiveSupport::TestCase
  setup do
    @answer1 = answers(:one)
    @answer2 = answers(:two)
  end
  
  test "that an answer has a sub_question id" do
    answer = @answer1
    assert !answer.save
  end
  
  test "that an answer has a user_id id" do
    answer = @answer2
    assert !answer.save
  end
end
