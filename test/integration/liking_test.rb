require 'test_helper'

class LikingTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @micropost = microposts(:ants)
    log_in_as(@user)
  end

  test "like micropost" do
    get root_path
    assert @user.likes.empty?
    assert_difference '@user.likes.count', 1 do
        post likes_path, xhr: true, params: { micropost_id: @micropost.id }
    end
  end

  test "unlike micropost" do
    log_in_as(@other_user)
    get root_path
    assert_not @other_user.likes.empty?
    like = @other_user.likes.find_by(micropost_id: @micropost.id)
    assert_difference '@other_user.likes.count', -1 do
        delete like_path(like), xhr: true
    end
  end
end