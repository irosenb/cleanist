require 'test_helper'
require "awesome_print"
require "pry"

class SignUpFlowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
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

  fixtures :users

  test "Login with pocket via OmniAuth" do
  	# https!
  	get "/"
  	assert_response :success 

    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:pocket]
  	get_via_redirect "/auth/pocket"
  	assert_includes path, "/confirm" 
    ap user = User.find(session[:user_id])
    # binding.pry
    assert_equal "irosenb", user.name
  end
end


