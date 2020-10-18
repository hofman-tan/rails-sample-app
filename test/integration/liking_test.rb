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
    get root_path
    assert @user.likes.empty?
    @user.like(@micropost)
    assert_not @user.likes.empty?
    like = @user.likes.find_by(micropost_id: @micropost.id)
    assert_difference '@user.likes.count', -1 do
        delete like_path(like), xhr: true
    end
  end

  
  test "should like a micropost the standard way" do
    assert_difference '@user.likes.count', 1 do
      post likes_path, params: { micropost_id: @micropost.id }
    end
  end

  test "should unlike a micropost the standard way" do
    @user.like(@micropost)
    like = @user.likes.find_by(micropost_id: @micropost.id)
    assert_difference '@user.likes.count', -1 do
        delete like_path(like)
    end
  end

  test "should like a micropost with Ajax" do
    assert_difference '@user.likes.count', 1 do
      post likes_path, xhr: true, params: { micropost_id: @micropost.id }
    end
  end

  test "should unlike a micropost with Ajax" do
    @user.like(@micropost)
    like = @user.likes.find_by(micropost_id: @micropost.id)
    assert_difference '@user.likes.count', -1 do
        delete like_path(like), xhr: true
    end
  end

end