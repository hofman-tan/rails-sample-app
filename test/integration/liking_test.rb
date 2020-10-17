require 'test_helper'

class LikingTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @micropost = microposts(:ants)
    log_in_as(@user)
  end

  test "like micropost" do
    get root_path
    assert_difference '@user.likes.count', 1 do
        post likes_path, params: { micropost_id: @micropost.id }
    end
  end
end