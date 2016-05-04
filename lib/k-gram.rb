require 'csv'
require 'stopwords'
class Gram
  attr_reader :n_gram, :tagged

  def initialize str, k
    @n_gram = Array.new
    @tagged = Hash.new
    @length = k
    process str
  end

  private

  def process str
    puts "\nprocessing"
    # first tokenize, then subdivide the string into words of @length long
    parse(tokenize str)
    # primarily focuses on eliminating grams with stop words
    initial_prune
    # safely store the tagged arrays - effectively reduces n-gram's depth ([[[]]] -> [[]])
    tag.each do |key, value|
      @tagged.store key, value
    end
  end

  # handles stop words, and potentially POS (part of speech)
  # later on will need to change to instead of discarding, demoting k-gram to k-1-gram
  # EX - "the black death" -> "black death"
  def initial_prune
    puts "\npruning"
    temp_arr = Array.new
    csv_path = File.expand_path('../words/en.csv', __FILE__)
    stopwords = CSV.read(csv_path)[0] #it all combines into one sub array anyway
    sieve = Stopwords::Filter.new stopwords
    @n_gram.each do |words|
      unless (sieve.filter(words)).length < @length
        temp_arr << words
      end
    end
    @n_gram = temp_arr
  end

  def tag
    puts "\ntagging"
    tagged_arr = Hash.new
    @n_gram.each_with_index do |item, index|
      item_count = count index
      if item_count > 1
        unless equals tagged_arr, item
          tagged_arr[item.clone] = item_count
        end
      end
    end
    tagged_arr
  end

  def tokenize str
    puts "\ntokenizing"
    arr = Array.new
    while str != nil
      char_arr = []
      index = str.index /[^a-zA-Z0-9]+/ #need to fix regex
      if index == nil
        index = str.length
      end
      result_string = (/[^a-zA-Z0-9]+/.match str[0])
      is_matched = false
      unless result_string == nil
        is_matched = true
      end
      while index == 0 && is_matched
        str.slice! 0
        index = str.index /[^a-zA-Z0-9]+/
      end
      str[0..index-1].each_char do |c|
        match_data = /([a-zA-Z0-9])+/.match c
        if match_data != nil
         char_arr << c
        end
      end
      arr << char_arr
      str = str.slice (index + 1)..(str.length() - 1)
    end
    arr
  end

  def parse tokens
    puts "\nparsing"
    pos = 0
    while pos < tokens.length - @length + 1
      word_arr = []
      (0..(@length-1)).each do |increment|
        word_arr << tokens[pos + increment].to_str
      end
      @n_gram << word_arr
      pos += 1
    end
  end

  def count index
    sum = 0
    test = @n_gram[index]
    @n_gram.each do |arr|
      if arr == test
        sum += 1
      end
    end
    sum
  end

  def equals array_base, sub_arr
    array_base.each do |item|
      if item == sub_arr
        return true
      end
    end
    false
  end
end