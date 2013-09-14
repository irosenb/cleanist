require "test_helper"
require "vcr"
# require "webmock/test_unit"


VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end

class PocketTest < ActiveSupport::TestCase
	setup do
    @user = users(:one)
  end

  test "should get pocket api link" do
  	assert_equal "https://getpocket.com/v3/", @user.url_base
  end

  test "user should be pocket class" do
    assert_equal "Pocket", @user.class.name
  end

  test "should retrieve pocket list" do
    VCR.use_cassette('items') do
      ap @user.options.merge!({:count => 15})
      @response = @user.retrieve
      @body = JSON.parse(@response.body)
      assert_equal @body["status"], 1
    end 
  end

  test "should choose items that are in users list and aren't tagged keep" do
    @body["list"][]
  end

  test "should archive list" do
  	
  end
end