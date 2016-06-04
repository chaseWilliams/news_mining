require 'rest-client'
require 'json'
require 'rss'
require './lib/k-gram.rb'
require './lib/array_extension.rb'
require './lib/wiki.rb'


file = IO.read './test_txt'
gram = Gram.new(file)
puts gram.tagged
puts Wiki.validate gram