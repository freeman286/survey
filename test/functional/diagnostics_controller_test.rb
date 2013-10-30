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
  
  test "should be redirected when not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render the new page when logged in and admin" do
    sign_in users(:joel)
    get :new
    assert_response :success
  end
end
