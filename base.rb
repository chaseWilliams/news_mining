require 'rest-client'
require 'json'
url = "https://hooks.slack.com/services/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"
puts
pay = {
    'username' => "ghost-bot",
    'icon_emoji' => ":ghost:",
    'text' => "this is a test"
}
pay = pay.to_json
puts pay
api_key = '71afeedbbc6287444bc2adf16897ec7ed2198bc4'
base = "http://access.alchemyapi.com/calls/info/GetAPIKeyInfo?apikey=#{api_key}&outputMode=json"
demo_endpoint = base





begin
  puts RestClient.get demo_endpoint
  puts 'success'
rescue => e
  puts e.response
end