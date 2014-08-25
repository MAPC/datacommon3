require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get data_day_2013" do
    get :data_day_2013
    assert_response :success
  end

  test "should get data_day_2012" do
    get :data_day_2012
    assert_response :success
  end

  test "should get data_day_2009" do
    get :data_day_2009
    assert_response :success
  end

  test "should get resources" do
    get :resources
    assert_response :success
  end

end
