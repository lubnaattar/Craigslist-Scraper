namespace :location_scraper do
desc "Save neighborhood codes in a reference table"
  task scrape_locations: :environment do
	  require 'open-uri'
	  require 'json'

	  # Set API token and URL
	  auth_token = "ca9d1ebd6d17828c658f0ef293e6a474"
	  location_url = "http://reference.3taps.com/locations"

	  # Specify request parameters
	  params = {
	    auth_token: auth_token,
	    level: "city",
	    state: "USA-CA"
	  }

	  # Prepare API request
	  uri = URI.parse(location_url)
	  uri.query = URI.encode_www_form(params)

	  # Submit request
	  result = JSON.parse(open(uri).read)

	  # Display results to screen
	  # puts JSON.pretty_generate result

	  # Store results in database
	  result["locations"].each do |location|
	    @location = Location.new
	    @location.code = location["code"]
	    @location.shortName = location["short_name"]
	    @location.longName = location["full_name"]
	    @location.save
	  end
	end
end