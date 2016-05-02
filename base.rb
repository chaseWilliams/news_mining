require 'rest-client'
require 'json_color'
require 'rss'
require './k-gram.rb'
require './array_extension.rb'
slack_url = "https://hooks.slack.com/services/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"

payload = {
    'username' => "Feedr",
    'icon_emoji' => ":gem:",
    'text' => "This is a test:\n#{@title}\n#{@link}"
}.to_json


file = IO.read './test_txt'
gram = Gram.new(file, 3)
print "Tagged combinations of words are: "
tags = gram.tagged
puts tags
puts tags.keys.first[2]
#begin
#  RestClient.post slack_url, payload, content_type: 'application/json'
#rescue RestClient::InternalServerError => e
#  "500 error"
#  puts e.response
#end