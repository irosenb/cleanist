class Pocket < ActiveRecord::Base
	belongs_to :platform, foreign_key: 'platform'
end