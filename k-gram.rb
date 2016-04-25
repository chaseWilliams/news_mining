require './array_extension.rb'
class Gram
  attr_accessor :n_gram
  #DELIMITER = [' ', ',', '.', ';', ':', '!', '?']

  def initialize str, k
    @n_gram = parse(tokenize(str), k)
  end

  private

  def tokenize str
    arr = []
    count = 0
    while str != nil
      puts "on count #{count}"
      char_arr = []
      index = str.index /[^a-zA-Z0-9]+/ #need to fix regex
      puts "The String is #{str} (#{str.length}), index is #{index}"
      if index == nil
        index = str.length
      end
      str[0..index-1].each_char {|c| 
        unless (c.index  /([^a-zA-Z0-9])+/).class == nil
         char_arr << c 
        end
      }
      print "The char array is #{char_arr}\n"
      arr << char_arr
      puts arr.length
      print "Final array is #{arr}\n"
      str = str.slice (index + 1)..(str.length() - 1)
      #puts str
      count += 1
    end
    arr
  end

  def parse tokens, k  #k is number of words per sub-array
    arr = []
    pos = 0
    while pos < tokens.length - k + 1
      word_arr = []
      (0..(k-1)).each do |increment|
        puts "attempting to find index #{pos + increment}"
        word_arr << tokens[pos + increment].to_str
      end
      puts "word array is #{word_arr}"
      arr << word_arr
      pos += 1
    end
    arr
  end
end

gram = Gram.new('this; is your. young, master chase', 3)
print gram.n_gram
puts "\n"