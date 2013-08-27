class User < ActiveRecord::Base
	belongs_to :platform, :polymorphic => true
	
end
