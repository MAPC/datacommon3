require 'test_helper'

class MunicipalitiesControllerTest < ActionController::TestCase
  test "should get topic" do
    get :topic
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
