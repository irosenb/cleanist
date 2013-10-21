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
			:consumer_key => consumer_key,
			:detailType => "complete"
		}
		# binding.pry
	end

	def retrieve
		url = 'get/'
		
		params = options.merge!({
			# :since => (since.to_i if defined? since)
			:count => 15
			})

		pocket_url = url_join(url_base, url)

		self.update 
		
		RestClient.post pocket_url, params
	end


	def to_archive
		list = JSON.parse(retrieve)
		id_list = []
		list["list"].each do |id, item|
			if !item["tags"].key?("keep") and item["status"] == "0"
				id_list << id 
			end
		end
		id_list
	end

	def archive
		url = 'send'
		actions = []
		to_archive.each do |id|
			action = {
				:action => "archive",
				:item_id => id
			}.to_json

			actions << action
		end
		
		archive = {:actions => actions}
		ap archive.merge!(options)
		ap pocket_url = url_join(url_base, url)
		
		RestClient.get pocket_url, {:params => archive}
	end

	def url_base
		version = "3" # If Pocket comes out with a new API version, this will come in handy.
		base_url = "https://getpocket.com/v#{version}/"
	end
end