module Animal
    def self.speak
        puts 'hello'
    end
    
    module Cat 
    def self.speak
        puts "yass"
    end
end
end



Animal::Cat.speak