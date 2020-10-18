require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "create should require logged-in user" do
    assert_no_difference 'Like.count' do
      post likes_path
    end
    assert_redirected_to login_url
  end

  test "destroy should require logged-in user" do
    assert_no_difference 'Like.count' do
      delete like_path(likes(:one))
    end
    assert_redirected_to login_url
  end

  test "should not view other user's likes" do
    log_in_as(@user)
    get likes_user_path(@other_user)
    assert_redirected_to root_path
  end
end
