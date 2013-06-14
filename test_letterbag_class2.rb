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
$letter_pool = $letter_pool.shuffle



#The LetterBag class is used to keep track of how many letters each player has.  It takes an array as input.
#If an object of player's letters is initialized, the call should take the form obj = LetterBag.new($letter_pool.pop(21))
#This will remove 21 letters from $letter_pool AND provide those same 21 letters to the player's LetterBag object
class LetterBag
  attr_accessor  :letter_hash

  #When the LetterBag class is initialized, it creates a hash that stores the number of each letter that each player has
  def initialize(letters)
    @letter_hash = Hash[("A".."Z").to_a.map {|letter| [letter,0]}]
    letters.each {|letter| @letter_hash[letter] += 1}
  end

  #During a "Peel", a new letter is removed from the letter pool array.  It is added to the player's LetterBag object and the hash is updated
  def peel(new_letter)
    @letter_hash[new_letter[0]] += 1
  end

  ###This method will be incorporated into make_word (6/12)
  def find_initial_word(player_bag)
    player_bag.clear_stored_words
    $dictionary.each do |element|
      @no_good = []
      dictionary_word = Word.new(element)
    
      dictionary_word.hash.each do |key,value|
        if value > player_bag.hash[key] 
          @no_good = 1
          break
        end
      end
    
      if @no_good == []
        puts element
        print player_bag.letters
        puts ""
        player_bag.store_word(element)
        break
      end
    
    end
  end

  def make_word(table)
    #This method will make a the largest possible  word from the available letters in a player's LetterBag and the player's Table
    #It will call the store_word method of the player's Table

    table.store_word

    word.each_char do |char|
      @letter_hash[char] -= 1
    end 
  end

end

print $letter_pool
puts ""

test_LB = LetterBag.new($letter_pool.pop(21))

print $letter_pool
puts ""

puts "I have:"
test_hash = test_LB.letter_hash
test_hash.each {|key, value| puts "#{value} #{key}'s"}
puts ""

test_LB.peel($letter_pool.pop)

print $letter_pool
puts ""
puts "I have:"
#test_hash = test_LB.hash
test_LB.letter_hash.each {|key, value| puts "#{value} #{key}'s"}
#puts ""
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
