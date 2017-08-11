require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get posts#index" do
    get posts_posts#index_url
    assert_response :success
  end

end
