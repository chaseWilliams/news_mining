
module Gram
    DELIMITER = [' ', ',', '.', ';', ':', '!', '?']
    def self.tokenize str, k
        arr = []
        char_arr = []
        index = 0
        count = 0
        while count < 2
            puts "on count #{count}"
            index = str.index /[ ]/ #space for now, will add more regex
            puts index == nil
            puts "The String is #{str.length}"
            if index.class == nil then index = str.length-1 end
            puts index 
            puts index.class 
            str[0..index].each_char {|c| char_arr << c }
            puts char_arr
            arr << char_arr
            puts arr.length
            puts arr
            str = str.slice (index + 1)..(str.length() - 1)
            puts str
            count += 1
        end
    end
end

Gram.tokenize 'hello world', 2