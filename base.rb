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
