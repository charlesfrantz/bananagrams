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
#$letter_pool = $letter_pool.shuffle



#The LetterBag class is used to keep track of how many letters each player has.  It takes an array as input.
#If an object of player's letters is initialized, the call should take the form obj = LetterBag.new($letter_pool.pop(21))
#This will remove 21 letters from $letter_pool AND provide those same 21 letters to the player's LetterBag object
class LetterBag 
  attr_accessor :letters#, :letters_hash

  #When the LetterBag class is initialized, it creates a hash that stores the number of each letter that each player has
  def initialize(letters)
    @letters = letters

    @letter_hash_pre = []
    ("a".."z").each {|s| @letter_hash_pre.push(s)}

    @letter_hash = Hash.new(0)
    @letter_hash_pre.each {|s| @letter_hash[s] = 0}
      if @letters != []
        @letters.each do |s|
          if @letter_hash.has_key?(s)
            @letter_hash[s] += 1
          end
        end
      end 
  end

  #During a "Peel", a new letter is taken from the letter pool LetterBag.  It is added to the player's LetterBag object's array of letters and the hash is updated
  def peel(new_letter)
    @letters.push(new_letter[0])
    if @letter_hash.has_key?(new_letter[0])
      @letter_hash[new_letter[0]] += 1
    end
  end

  #Used to remove letters from the pool LetterBag.  This method updates the letter_pool array and it's hash
  def remove_letters(n)
    @letters = @letters.shuffle
    @letters_tobe_removed = @letters.pop(n)
    return @letters_tobe_removed
 
    @letters_tobe_removed.each do |s|
      @letter_hash[s] -=1
      @letters_tobe_removed.pop
    end
  end

  def hash
    return @letter_hash
  end

  def total
    return @letters.length
  end

end

##Takes string as input
#class Word
#  attr_accessor :word
#
#  def initialize(word = [])
#    @word = word
#    @word_hash = Hash.new(0)
#
#    if @word != []
#      @word.each_char do |s|
##          puts "I'm making the hash"
#          if @word_hash.has_key?(s)
#            @word_hash[s] = @word_hash[s] + 1
#          else
#            @word_hash[s] = 1
#          end  
#      end
##      puts "I've made the hash"
#    end
#  end
#
#  def hash
#    return @word_hash
#  end 
#
#  def show_hash
#    @word_hash.each do |key, value|
#      puts "#{key} is #{value}"
#    end
#  end
#
#end
#
letter_pool_bag = LetterBag.new($letter_pool)
#
#
##puts "There are #{$letter_pool.length} letters in the pool."
puts "There are #{letter_pool_bag.total} letters in the pool."


test_LB = LetterBag.new(letter_pool_bag.remove_letters(21))

puts "#{test_LB.letters}"
puts ""

puts "There are #{letter_pool_bag.total} letters in the pool."

puts "I have #{test_LB.total} letters"
puts "I have:"
test_hash = test_LB.hash
test_hash.each {|key, value| puts "#{value} #{key}'s"}
puts ""

test_LB.peel(letter_pool_bag.remove_letters(1))
puts "There are #{letter_pool_bag.total} letters in the pool."
puts "#{test_LB.letters}"
puts "I have #{test_LB.total} letters"
puts "I have:"
test_hash = test_LB.hash
test_hash.each {|key, value| puts "#{value} #{key}'s"}
puts ""
#
#
#player1_bag = LetterBag.new(letter_pool_bag.remove_letters(21))
#
##FIGURE OUT HOW TO EFFECTIVELY CHECK THAT player1_bag has all of the required letters in a given word.  Look at 
##make_bananagrams_dictionary.rb for ideas
#$check_break = []
#
#$dictionary.each do |element|
#  @no_good = []
#  dictionary_word = Word.new(element)
##  dictionary_word_hash = dictionary_word.hash
#  dictionary_word.hash.each do |key,value|
#    if value > player1_bag.hash[key]   #Note, if player1_bag does not have certain letters, this comparison will not work
#      @no_good = 1
#      break
#    end
#      puts element
#      puts player1_bag.letters
#      #$check_break = 1
#      break
#    #end
#  end
#  
# # if $check_break == 1
# #   break
# # end
#end
#
#
#
##puts $dictionary
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
