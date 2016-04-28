require 'rest-client'
require 'json_color'
require 'rss'
slack_url = "https://hooks.slack.com/services/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"
puts

feed_url = 'http://feeds.feedburner.com/TechCrunch/'
RestClient.get feed_url do |rss|
  feed = RSS::Parser.parse(rss)
  puts feed.items.first.title
  puts feed.items.first.link
  @title = feed.items.first.title
  @link = feed.items.first.link
  puts "Title: #{feed.channel.title}"
  #feed.items.each do |item|
    puts "Item: #{feed.items.first}"
  #end
end

payload = {
    'username' => "Feedr",
    'icon_emoji' => ":gem:",
    'text' => "This is a test:\n#{@title}\n#{@link}"
}.to_json

#begin
#  RestClient.post slack_url, payload, content_type: 'application/json'
#rescue RestClient::InternalServerError => e
#  "500 error"
#  puts e.response
#end