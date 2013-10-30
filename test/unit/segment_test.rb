require 'test_helper'

class SegmentTest < ActiveSupport::TestCase
  setup do
    @segment1 = segments(:one)
    @segment2 = segments(:two)
    @segment3 = segments(:three)
  end
  
  test "that a name segment requires a name" do
    segment = @segment1
    assert !segment.save
  end

  test "that a segment's name is at least 2 letters" do
    segment = @segment2
    assert !segment.save
  end
  
  test "that a segment has a diagnostic id" do
    segment = @segment3
    assert !segment.save
  end
end
