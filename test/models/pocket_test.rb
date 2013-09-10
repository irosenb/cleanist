require "test_helper"

class PocketTest < ActiveSupport::TestCase
	setup do
    @user = users(:one)
  end

  test "should get pocket api link" do
  	assert_equal "https://getpocket.com/v3/", @user.url_base
  end

  test "should retrieve pocket list" do
  	assert_not_nil @user.to_archive
  end

  test "should archive list" do
  	
  end
end