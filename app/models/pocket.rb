class Pocket < User

	def retrieve
		url = 'get/'
		token = self.token
		consumer_key = ENV['POCKET_KEY']

		options = {
			:access_token => token,
			:consumer_key => consumer_key, 
			:since => (since.to_i if defined? since)
		}
		pocket_url = url_join(url_base, url)

		self.update 
		
		RestClient.post pocket_url, options
	end

	def to_archive
		puts list = JSON.parse(retrieve)
		id_list = []
		list["list"].each do |id, item|
			if item["tag"] != "keep" or item["status"] == 0
				id_list << id 
			end
		end
		id_list
	end

	def archive
		# @to_archive.each do |id|
			
		# end
	end

	def url_base
		version = "3" # If Pocket comes out with a new API version, this will come in handy.
		base_url = "https://getpocket.com/v#{version}/"
	end
end