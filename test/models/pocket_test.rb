require "test_helper"
require "vcr"


VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end

class PocketTest < ActiveSupport::TestCase
	setup do
    @user = users(:one)
  end

  test "should get pocket api link" do
  	assert_equal "https://getpocket.com/v3/", @user.url_base
  end

  test "should retrieve pocket list" do
    VCR.use_cassette('items') do
      @user.options.merge!({:count => 30})
      @response = @user.retrieve
      assert_includes @response, "tag"  
    end 
  end

  test "should archive list" do
  	
  end
end