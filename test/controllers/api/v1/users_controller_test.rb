require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users(:saurabh)
  end

  test "should show user" do
    get api_v1_user_url(@user), as: :json
    assert_response :success
    json_response = JSON.parse(self.response.body,symbolize_names: true)
    assert_equal @user.email, json_response.dig(:data,:attributes, :email)
    assert_equal @user.products.first.id.to_s, json_response.dig(:data, :relationships, :products, :data, 0, :id)
    assert_equal @user.products.first.title, json_response.dig(:included, 0, :attributes, :title)
  end

  test "should create new user" do
    new_email = "srk@gmail.com"
    password = "1234"
    assert_difference('User.count') do
      post api_v1_users_url, params: { user: { email: new_email, 
                                              password: password }}, as: :json
    end
    assert_response :created
  end

  test "should not create a new user with taken email" do
    new_email = @user.email
    password = "1234"
    assert_no_difference('User.count') do
      post api_v1_users_url, params: { user: { email: new_email, 
                                              password: password }}, as: :json
    end
    assert_response :unprocessable_entity
  end

  test "should update user" do
    new_email = "new@gmail.com"
    password = "1234"
    patch api_v1_user_url(@user), 
    params: { user: { email: new_email, password: password }}, 
    headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }, as: :json
    @user.reload
    assert_equal @user.email, new_email
    assert_response :success
  end

  test "should forbid update user" do 
    patch api_v1_user_url(@user), params: { user: { email: @user.email } }, as: :json 
    assert_response :forbidden 
  end

  test "should not update user when invalid params are sent" do
    new_email = 'bad_email'
    patch api_v1_user_url(@user), params: { user: { email: new_email, password: '1234' } }, 
    headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }, as: :json 
    @user.reload
    assert_not_equal @user.email, new_email
    assert_response :unprocessable_entity 
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete api_v1_user_url(@user), 
      headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }, as: :json
    end
    assert_response :no_content
  end

  test "should forbid destroy user" do
    assert_no_difference('User.count') do
      delete api_v1_user_url(@user), as: :json
    end
    assert_response :forbidden
  end
end
