class Pocket < ActiveRecord::Base
	has_one :user, as: :platform
end