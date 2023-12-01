# frozen_string_literal: true

# Define a class
class String
  def shuffle
    self.split('').shuffle.join
  end

end

def string_shuffle(s)
  s.chars.shuffle.join
end
# Пример использования нового метода shuffle
shuffled_string = string_shuffle("hello")
puts shuffled_string

person1 = { :first => "John", :last => "Doe" }
person2 = { :first => "Jane", :last => "Doe" }
person3 = { :first => "Alice", :last => "Doe" }

params = {
  :father => person1,
  :mother => person2,
  :child => person3
}

# Проверим, что params[:father][:first] имеет правильное значение
puts params[:father][:first]  # Выведет "John"

