require 'rest-client'
uri = 'https://en.wikipedia.org/w/api.php?action=query&format=json&' + 'prop=extracts&pageids=8871033'

puts JSON.pretty_generate JSON.parse RestClient::Request.execute(:url => URI.encode(uri), :method => :get, :verify_ssl => false)