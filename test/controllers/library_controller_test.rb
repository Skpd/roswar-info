require 'test_helper'

class LibraryControllerTest < ActionController::TestCase
  test "should get max-stats" do
    get :max_stats
    assert_response :success
  end
end
