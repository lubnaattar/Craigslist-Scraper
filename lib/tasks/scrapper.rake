namespace :scrapper do
  desc "Fetch craigslist data from 3taps"
  task scrape: :environment do

  	require 'open-uri'
	require 'json'

	# Set API token and URL
	auth_token = "ca9d1ebd6d17828c658f0ef293e6a474"
	polling_url = "http://polling.3taps.com/poll"
	anchor_url = "http://polling.3taps.com/anchor"

	# Specify request  parameters for anchor url\
	anchor_params = {
		auth_token: auth_token,
		timestamp:1426853520#1426420800 #1426377600
	}
	#1985469445
	anchor_uri = URI.parse(anchor_url)
	anchor_uri.query = URI.encode_www_form(anchor_params)

	# Submit request
	anchor_result = JSON.parse(open(anchor_uri).read)
	#anchor = anchor_result.first["anchor"]
	puts anchor_result  # to_s converts to string
	# Specify request  parameters for polling url
	params = {
	  auth_token: auth_token,
	  anchor:anchor_result["anchor"], #3/15/2015
	  source: "CRAIG",
	  category_group: "VVVV",
	  category: "VAUT",
	  'location.state' => "USA-CA",
	  retvals: "id,account_id,source,category,category_group,location,external_id,external_url,heading,body,timestamp,timestamp_deleted,expires,language,price,currency,images,annotations,status,state,immortal,deleted,flagged_status"
	}

	#http://polling.3taps.com/anchor?auth_token=ca9d1ebd6d17828c658f0ef293e6a474&

	# Prepare API request
	uri = URI.parse(polling_url)
	uri.query = URI.encode_www_form(params)

	# Submit request
	result = JSON.parse(open(uri).read)

	# Display results to screen
	# this displays ll data in terminal
	# puts results
	# puts JSON.pretty_generate result
	# puts JSON.pretty_generate result["postings"]
	 puts JSON.pretty_generate result["postings"].first
	 puts JSON.pretty_generate result["postings"].second
	 
	# puts JSON.pretty_generate result["postings"].first["heading"] --> this will give error cos output need to be displayed in string

	# puts result["postings"].first["heading"] # dis output as string
	# puts result["postings"].first["body"] # dis
	# puts result["postings"].second["location"]["locality"] # dis
	
	# Saving outpout to file
	# output = File.open( "outputfile.json","w" )
	# output << result
	# output.close

	  result["postings"].each do |posting|

	  # Create new Post
	  	@post = Post.new
		
	      @post.heading = posting["heading"]
	      @post.body = posting["body"]
	      @post.price = posting["price"]
	      #@post.neighborhood = posting["location"]["locality"]
	      @post.external_url = posting["external_url"]
	      @post.year = posting["annotations"]["year"]	if posting["annotations"]["year"].present?
	      @post.phone = posting["annotations"]["phone"] if posting["annotations"]["phone"].present? 
	      @post.paint_color = posting["annotations"]["paint_color"] if posting["annotations"]["paint_color"].present?
	      @post.paint_color = posting["annotations"]["drive"] if posting["annotations"]["drive"].present?
	       @post.flagged_status = posting["flagged_status"] if posting["flagged_status"].present?
	     
	      # @post.state = posting["location"]["state"]
	      # @post.city = posting["location"]["city"]
	      # @post.zipcode = posting["location"]["zipcode"]
	       @post.neighborhood =Location.find_by(code: posting["location"]["locality"]).try(:shortName)
	      @post.state = "California"
	      @post.city =Location.find_by(code: posting["location"]["city"]).try(:shortName)
	      @post.zipcode =Location.find_by(code: posting["location"]["zipcode"]).try(:shortName)
	      

      	 # @post.id = posting["id"]
		#  @post.account_id = posting["account_id"]

		#@post = Post.new
		# @post.source = posting["source"]
		# @post.category = posting["category"]
		# @post.category_group = posting["category_group"]
		# @post.location_state = posting["location"]["state"]
		# @post.location_city = posting["location"]["city"]
		# @post.external_id = posting["external_id"]
		# @post.external_url = posting["external_url"]
		# @post.heading = posting["heading"]
		# @post.body = posting["body"]
		# @post.timestamp = posting["timestamp"]
		# @post.timestamp_deleted = posting["timestamp_deleted"]
		# @post.expires = posting["expires"]
		# @post.language = posting["language"]
		# @post.price = posting["price"]
		# @post.currency = posting["currency"]
		# @post.status = posting["status"]
		# @post.state = posting["state"]
		# @post.immortal = posting["immortal"]
		# @post.deleted = posting["deleted"]
		# @post.flagged_status= posting["flagged_status"]


	  # Save Post
	   @post.save
	   posting["images"].each do |image|
      @image = Image.new
      @image.url = image["full"]
      @image.post_id = @post.id 
      @image.save

		end

	end

  end

  desc "Destroy All Posts"
  task destroy_all_posts: :environment do
  	Post.destroy_all
  end
  ## run this as rake scrapper:scrape_locations level='locality'
  ## run this as rake scrapper:scrape_locations level='city'
  ## run this as rake scrapper:scrape_locations level='zipcode'
  desc "Save neighborhood codes in a reference table"
  task scrape_locations: :environment do
	  require 'open-uri'
	  require 'json'

	  level = ENV['level']

	  # Set API token and URL
	  auth_token = "ca9d1ebd6d17828c658f0ef293e6a474"
	  location_url = "http://reference.3taps.com/locations"

	  # Specify request parameters
	  params = {
	    auth_token: auth_token,
	    level: level,
	    state: "USA-CA"
	  }

	  # Prepare API request
	  uri = URI.parse(location_url)
	  uri.query = URI.encode_www_form(params)

	  # Submit request
	  result = JSON.parse(open(uri).read)

	  # Display results to screen
	#	  puts JSON.pretty_generate result

	  # Store results in database
	   result["locations"].each do |location|
	    @location = Location.new
	    @location.level = level
	    @location.code = location["code"]
	    @location.shortName = location["short_name"]
	    @location.longName = location["full_name"]
	    @location.save
	  end
	end

	desc "try argument"
	task argument: :environment  do
		###rake scrapper:argument level='zipcode'
		my_level = ENV['level']
		puts my_level
	end
end


