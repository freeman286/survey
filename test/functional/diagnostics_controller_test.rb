require 'test_helper'

class DiagnosticsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @diagnostic = diagnostics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:diagnostics)
  end

  test "should show diagnostic" do
    get :show, id: @diagnostic
    assert_response :success
  end
end
