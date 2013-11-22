require 'test_helper'
require "delayed_job_active_record"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = users(:one)
  end

  test "user can join urls" do
    word = "world"
    url_base = @user.url_base
    assert_equal "#{url_base}#{word}", @user.url_join(word)

  end

  test "user can update" do
    before = @user.updated_at
    
    @user.update

    after = @user.updated_at
    assert_not_equal before, after 
  end

  test "user has since property" do
    assert_nil @user.since
    
    # update, see if it worked
    @user.update
    created = @user.created_at
    assert_not_equal created, @user.since
  end
end
