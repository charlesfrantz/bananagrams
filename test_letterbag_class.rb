#!/usr/bin/ruby




#Defines the dictionary as an array of words from bananagrams_dictionary.txt
$dictionary = []
File.open("bananagrams_dictionary.txt") do |file|
  file.each_line { |line| $dictionary.push line.strip }
end
$dictionary.sort! { |left,right| right.length <=> left.length  }
#puts $dictionary.length

#Defines the pool of available letters in a bananagrams game
$letter_pool = []
File.open("letters.txt") do |file|
  file.each_line { |line| $letter_pool.push line.strip }
end
#There is a "" at the end of $letter_pool, so we'll pop it off
$letter_pool.pop
#The letter_pool is shuffled so that players will get random letters from the pool
$letter_pool = $letter_pool.shuffle



#The LetterBag class is used to keep track of how many letters each player has
#If an object of player's letters is initialized, the call should take the form obj = LetterBag.new($letter_pool.pop(21))
#This will remove 21 letters from $letter_pool AND provide those same 21 letters to the player's LetterBag object
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
  #In order for the new letter to be removed from $letter_pool, new_letter must be gotten by $letter_pool.pop
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

puts "There are #{$letter_pool.length} letters in the pool."
test_LB = LetterBag.new($letter_pool.pop(21))
puts "#{test_LB.letters}"
puts ""

puts "There are #{$letter_pool.length} letters in the pool."
puts "I have #{test_LB.total} letters"
#puts "I have:"
#test_hash = test_LB.hash
#test_hash.each {|key, value| puts "#{value} #{key}'s"}

test_LB.take_letter($letter_pool.pop)
puts "There are #{$letter_pool.length} letters in the pool."
puts "#{test_LB.letters}"
puts "I have #{test_LB.total} letters"


 # def show_string
 #   puts "#{@word}" 
 # end
 
#  def return_hash 
#
#    @word_hash = Hash.new(0)
##    puts "WTF?" 
#    if @word != []
##    puts "here I am"
#      @word.each_char do |s|
##          puts "I'm making the hash"
#          if @word_hash.has_key?(s)
#            @word_hash[s] = @word_hash[s] + 1
#          else
#            @word_hash[s] = 1
#          end  
#      end
##      puts "I've made the hash"
#      return @word_hash
#    end
#  end
#
#  def show_hash
#    @word_hash.each do |key, value|
#      puts "#{key} is #{value}"
#    end
#  end

#end

#test_word_arr = ["pillow","zzz", "zxx", "aabbccdd"]
#
#test_word_arr.each do |test_word|
#  test_word = Word.new(test_word)
#  puts "The word is " + test_word.word
#  
#  a = test_word.return_hash
#  a.each do |key, value|
#    if value == 1
#    puts "There is #{value} #{key} in the word"
#    else
#    puts "There are #{value} #{key}'s in the word"
#    end
#  end
#end
#if __FILE__ == $0
#  wordTest = Word.new
#  wordTest.show_string
#
#  wordTest.word = "pizza"
#  wordTest.show_string
#  wordTest.show_hash
#end





#Creates a hash of all the letters in the pool with their associated quantity
$letters = Hash.new(0)

$letter_pool.each do |letter|
      if $letters.has_key?(  "#{ letter }")
      	#puts "#{letter}"
	$letters ["#{ letter }"]= $letters["#{ letter }"] + 1
      else
      	$letters ["#{ letter}"] = 1
	#puts "#{letter}"
	end
end

#$letters.each do |key, value| 
#	puts "#{key} is #{value}"
#end
