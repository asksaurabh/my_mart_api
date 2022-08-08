require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users(:saurabh)
  end

  test "should show user" do
    get api_v1_user_url(@user), as: :json
    assert_response :success
    # Test to ensure response contains the correct email
    json_response = JSON.parse(self.response.body)
    assert_equal @user.email, json_response["email"]
  end

  test "should create new user" do
    new_email = "kk@gmail.com"
    password = "1234"
    assert_difference('User.count') do
      post api_v1_users_url, params: { user: { email: new_email, 
                                              password: password }}, as: :json
    end
    assert_response :created
  end

  test "should not create a new user wit taken email" do
    new_email = @user.email
    password = "1234"
    assert_no_difference('User.count') do
      post api_v1_users_url, params: { user: { email: new_email, 
                                              password: password }}, as: :json
    end
    assert_response :unprocessable_entity
  end
end
