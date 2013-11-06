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
			:detailType 	=> "complete"
		}
		# binding.pry
	end

	def retrieve
		url = 'get/'
		
		params = options.merge!({
			:since => (since.to_i if defined? since)
			})

		pocket_url = url_join(url)

		self.update 
		
		response = RestClient.post pocket_url, params
		# delay(:run_at => 1.weeks.from_now).archive
		return response
	end


	def to_archive
		ap list = JSON.parse(retrieve)
		id_list = []
		list["list"].each do |id, item|
			ap item["tags"]
			if item["tags"].try(:[], "keep").nil? and item["status"] == "0"
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
		ap pocket_url = url_join(url)
		
		RestClient.get pocket_url, {:params => archive}
	end

	def url_base
		version = "3" # If Pocket comes out with a new API version, this will come in handy.
		url_base = "https://getpocket.com/v#{version}/"
	end
end