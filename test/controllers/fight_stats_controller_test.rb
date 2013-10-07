require 'test_helper'

class FightStatsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test 'should show fight' do
    get :show, :id => 1
    assert_response :success
  end

  test 'should create fight' do
    post :create, {:fight => {:url => 'http://www.roswar.ru/fight/275535'}}
    assert_response :redirect
    assert_redirected_to :action => :show, :id => '275535'
  end
end
