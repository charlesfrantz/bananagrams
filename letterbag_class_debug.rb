



a = %w{ a b c d e f g h a c d b g h i }



class LetterBag
  attr_accessor :letters#, :letters_hash

  #When the LetterBag class is initialized, it creates a hash that stores the number of each letter that each player has
  def initialize(letters)
    @letters = letters
    @letter_hash = Hash.new(0)
      if @letters != []
        @letters.each do |s|
          if @letter_hash.has_key?(s)
            @letter_hash[s] += 1
          else
            @letter_hash[s] = 1
          end
        end
      end
  end
  
  #When a new letter is taken from $letter_pool, it is added to the LetterBag object's array of letters and the hash is updated
  def take_letter(new_letter)
    @letters.push(new_letter)
    if @letter_hash.has_key?(new_letter)
      @letter_hash[2] += 1
    else
      @letter_hash[new_letter] = 1
    end
  end

  def hash
    return @letter_hash
  end

  def total
    return @letters.length
  end

end




test_LB = LetterBag.new(a)
b = test_LB.hash
b.each {|key, value| puts "#{value} #{key}'s"}
puts ""
test_LB.take_letter("z")
b = test_LB.hash
b.each {|key, value| puts "#{value} #{key}'s"}
