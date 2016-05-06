module Validator
    def self.validate gram
        endpoint_base = 'https://en.wikipedia.org/w/api.php?action=query&format=json&'
        endpoint_rand = "&list=random&rnlimit=5"
        endpoint_article = 'prop=extracts&titles='
        gram.tagged.each do |key, value|
            str = key[0].capitalize + "_" + key[1]
            uri = endpoint_base + endpoint_article + "#{str}"
            response = JSON.parse RestClient::Request.execute(:url => URI.encode(uri), :method => :get, :verify_ssl => false)
            begin 
                hash_keys = response['query']['pages'].keys
                result = response['query']['pages'][hash_keys[0]]['extract']
                index = result.index '</p>'
                unless index.nil?
                    extract = result.slice 0, index
                    hash[key] = {
                        url: uri,
                        extract: extract
                    }
                end
            rescue NoMethodError 
                puts "looks like #{uri} doesn't exist in Wikipedia"
            end
        end
    end

puts "final result is #{JSON.pretty_generate hash}"
uri = endpoint_base + endpoint_rand
response = JSON.parse RestClient::Request.execute(:url => URI.encode(uri), :method => :get, :verify_ssl => false)
puts JSON.pretty_generate response
# persist hash to database
    end
    
    def persist new_vals
        #persist the new values to db
    end
        
end