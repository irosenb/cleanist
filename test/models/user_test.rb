require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = users(:one)
  end

  test "user can join urls" do
    part_one = "hello"
    part_two = "world" 
    assert_equal "helloworld", @user.url_join(part_one, part_two)

  end

  test "user can update" do
    before = @user.updated_at
    sleep(1)
    
    assert @user.update

    after = @user.updated_at
    assert_not_equal before, after 
  end

  test "user has since property" do
    puts "----------"
    puts @user.since
    puts "----------"
    assert_nil @user.since
    
    # update, see if it worked
    @user.update
    created = @user.created_at
    assert_not_equal created, @user.since
  end

  # test ""
end
