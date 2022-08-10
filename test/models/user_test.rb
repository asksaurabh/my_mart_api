require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:saurabh)
  end
  
  test "user with a valid email should be valid" do
    assert @user.valid?
  end

  test "user with invalid email should be invalid" do
    @user.email = "happpygmail.com"
    assert_not @user.valid?
  end

  test "user with taken email should be invalid" do
    other_user = users(:saurabh)
    @user = User.new(email: other_user.email, password_digest: "hhdh")
    assert_not @user.valid?
  end

  test "destroy user should destroy linked product" do
    assert_difference('Product.count', -1) do 
      users(:saurabh).destroy 
    end
  end
end
