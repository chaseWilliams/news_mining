
class Gram
  attr_reader :n_gram, :tagged

  def initialize str, k
    @n_gram = Array.new
    @tagged = Hash.new
    process str, k
  end

  def process str, k
    @n_gram[@n_gram.length] = parse(tokenize(str), k)
    puts "final result is #{@n_gram}"
    temp_hash = tag
    temp_hash.each do |key, value|
      @tagged.store key, value
    end
    puts "tagged words are #{@tagged}"
  end

  private

  def tag
    puts "tagging!"
    tagged_arr = Hash.new;
    @n_gram.each_with_index do |item, index|
      puts "comparing item #{item} at index #{index}"
      item_count = count index
      puts item_count
      if item_count > 1
        puts "item count greater than one! (#{item})"
        unless equals tagged_arr, item
          puts "adding new item #{item}"
          tagged_arr[item.clone] = item_count
        end
      end
    end
    puts "the tagged array is #{tagged_arr}"
    tagged_arr
  end

  def tokenize str
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
        puts "entered loop for guarding against index 0"
        str.slice! 0
        index = str.index /[^a-zA-Z0-9]+/
      end
      str[0..index-1].each_char do |c|
        match_data = /([a-zA-Z0-9])+/.match c
        if match_data != nil
         char_arr << c
        end
      end
      print "The char array is #{char_arr}\n"
      arr << char_arr
      puts arr.length
      print "Final array is #{arr}\n"
      str = str.slice (index + 1)..(str.length() - 1)
    end
    arr
  end

  def parse tokens, k  #k is number of words per sub-array
    arr = []
    pos = 0
    while pos < tokens.length - k + 1
      word_arr = []
      (0..(k-1)).each do |increment|
        word_arr << tokens[pos + increment].to_str
      end
      puts "word array is #{word_arr}"
      arr << word_arr
      pos += 1
    end
    arr
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
    return false
  end
end