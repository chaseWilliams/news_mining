require 'rest-client'
require 'json'
require 'rss'
require './lib/k-gram.rb'
require './lib/array_extension.rb'

hash = Hash.new
file = IO.read './test_txt'
gram = Gram.new(file, 2)
print gram.tagged
puts "\n"
gram.tagged.each do |key, value|
    str = key[0].capitalize + "_" + key[1]
    endpoint_base = 'https://en.wikipedia.org/w/api.php?action=query&'
    endpoint_article = 'prop=extracts&format=json&titles='
    uri = endpoint_base + endpoint_article + "#{str}"
    response = JSON.parse RestClient::Request.execute(:url => URI.encode(uri), :method => :get, :verify_ssl => false)
    begin 
        hash_keys = response['query']['pages'].keys
        result = response['query']['pages'][hash_keys[0]]['extract']
        index = result.index '</p>'
        extract = result.slice 0, index
        hash[key] = {
            url: uri,
            extract: extract
        }
    rescue NoMethodError => e
        puts "looks like #{uri} doesn't exist in Wikipedia"
    end
end

puts "final result is #{JSON.pretty_generate hash}"

# persist hash to database