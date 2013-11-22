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
		# binding.pry
	end

	def retrieve
		url = 'get/'
		
		params = options.merge!({
			:detailType 	=> "complete"
			})

		pocket_url = url_join(url)

		self.update 
		
		response = RestClient.post pocket_url, params
		# puts "-------"
		# puts Delayed::Job.enqueue(archive)
		# puts "-------"
		return response
	end


	def to_archive
		list = JSON.parse(retrieve)
		id_list = []
		# Go back a week ago.
		date = Date.today - 7
		date = date.to_time.to_i
		list["list"].each do |id, item|
			# item["tags"]
			if item["tags"].try(:[], "keep").nil? and item["status"] == "0" and item["time_added"].to_i < date
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
				:item_id => id,
				:time => Time.now.to_i
			}

			actions << action
		end
		
		archive = {:actions => actions.to_json}
		archive.merge!(options)
		pocket_url = url_join(url)
		
		RestClient.get pocket_url, {:params => archive}
	end

	def url_base
		version = "3" # If Pocket comes out with a new API version, this will come in handy.
		url_base = "https://getpocket.com/v#{version}/"
	end
end