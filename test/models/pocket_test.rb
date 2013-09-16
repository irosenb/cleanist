require "test_helper"
require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.allow_http_connections_when_no_cassette = true
  c.hook_into :webmock
end

class PocketTest < ActiveSupport::TestCase
  attr_accessor :body
	setup do
    @user = users(:one)
    VCR.use_cassette('items') do
      @user.options.merge!({:count => 15})
      @response = @user.retrieve
      @body = JSON.parse(@response.body)
    end
  end

  test "should get pocket api link" do
  	assert_equal "https://getpocket.com/v3/", @user.url_base
  end

  test "user should be pocket class" do
    assert_equal "Pocket", @user.class.name
  end

  test "should retrieve pocket list" do
    assert_equal @body["status"], 1
  end

  test "should choose items that are in users list and aren't tagged keep" do
    VCR.use_cassette('items') do
      list = @body["list"]
      expected_list = @user.to_archive

      expected_list.each do |item|
        assert_not_nil   list[item]
        assert_equal     list[item]["status"], "0"
        assert_not_equal list[item]["tag"]   , "keep"
      end 
    end
  end

  test "should archive list" do
  	VCR.use_cassette('items') do
      @user.archive
    end
  end
end