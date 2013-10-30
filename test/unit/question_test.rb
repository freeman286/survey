require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  setup do
    @question1 = questions(:one)
    @question2 = questions(:two)
    @question3 = questions(:three)
  end
  
  test "that a name question requires a name" do
    question = @question1
    assert !question.save
  end

  test "that a question's name is at least 2 letters" do
    question = @question2
    assert !question.save
  end
  
  test "that a question has a segment id" do
    question = @question3
    assert !question.save
  end
end
