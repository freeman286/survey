require 'test_helper'

class Subsub_questionTest < ActiveSupport::TestCase
  setup do
    @sub_question1 = sub_questions(:one)
    @sub_question2 = sub_questions(:two)
    @sub_question3 = sub_questions(:three)
  end
  
  test "that a name sub_question requires a name" do
    sub_question = @sub_question1
    assert !sub_question.save
  end

  test "that a sub_question's name is at least 2 letters" do
    sub_question = @sub_question2
    assert !sub_question.save
  end
  
  test "that a sub_question has a question id" do
    sub_question = @sub_question3
    assert !sub_question.save
  end
end
