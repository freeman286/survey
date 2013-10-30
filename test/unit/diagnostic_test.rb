require 'test_helper'

class DiagnosticTest < ActiveSupport::TestCase
  setup do
    @diagnostic1 = diagnostics(:one)
    @diagnostic2 = diagnostics(:two)
    @diagnostic3 = diagnostics(:three)
    @diagnostic4 = diagnostics(:four)
  end
  
  test "that a name diagnostic requires a name" do
    diagnostic = @diagnostic1
    assert !diagnostic.save
  end

  test "that a diagnostic's name is at least 2 letters" do
    diagnostic = @diagnostic2
    assert !diagnostic.save
  end
  
  test "that a name diagnostic requires a description" do
    diagnostic = @diagnostic3
    assert !diagnostic.save
  end

  test "that a diagnostic's description is at least 2 letters" do
    diagnostic = @diagnostic4
    assert !diagnostic.save
  end
end
