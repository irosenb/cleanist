class User < ActiveRecord::Base
	attr_reader :since, :url_base, :service_url, :to_archive 

	def since
		# time since last logged in.
		# update time UNLESS it's a new person.
		unless self.updated_at == self.created_at
			@since = self.updated_at
		end
	end

	def update
		# update time last logged in to current time
		self.touch
	end

	def url_join(base, url)
		[base, url].join("")
	end

	def to_archive
		[]
	end

	def retrieve
	end
end
