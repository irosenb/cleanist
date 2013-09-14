class Pocket < User
	attr_accessor :options

	def self.model_name
		User.model_name
	end

	def options
		token = self.token
		consumer_key = ENV['POCKET_KEY']
		
		@options = {
			:access_token => token,
			:consumer_key => consumer_key
		}
	end

	def retrieve
		url = 'get/'
		# token = self.token
		# consumer_key = ENV['POCKET_KEY']
		
		ap params = @options.merge!({
			:since => (since.to_i if defined? since)
			})

		pocket_url = url_join(url_base, url)

		self.update 
		
		RestClient.post pocket_url, params
	end


	def to_archive
		ap list = JSON.parse(retrieve)
		id_list = []
		list["list"].each do|id, item|
			if item["tag"] != "keep" and item["status"] == "0"
				id_list << id 
			end
		end
		id_list
	end

	def archive
		url = 'send'
		ap archive = @options
		to_archive.each do |id|
			action_hash = {
				:action => "archive",
				:item_id => id
			}
			ap archive.merge!(id => action_hash)
		end
		pocket_url = url_join(url_base, url)
		# archive.
	end

	def url_base
		version = "3" # If Pocket comes out with a new API version, this will come in handy.
		base_url = "https://getpocket.com/v#{version}/"
	end
end