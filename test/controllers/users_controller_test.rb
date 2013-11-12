require 'test_helper'
require "pry"

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:pocket] = OmniAuth::AuthHash.new ({
      :provider => 'pocket',
      :uid => '1234',
      :info => {
        :name => 'irosenb'
      },
      :credentials => {
        :token => '8996e844-2e26-301d-6e7f-381418'
      }
    })
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:pocket]
    assert_difference('User.count') do
      # binding.pry
      post :create
    end

    assert_redirected_to "/confirm"
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { name: @user.name, type: "#{@user.type}".capitalize, token: @user.token }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
