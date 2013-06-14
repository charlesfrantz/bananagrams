#!/usr/bin/ruby


#RETRIEVE WORDS AND LETTERS FROM TXT FILES
#=========================================

#Defines the dictionary as an array of words from bananagrams_dictionary.txt
$dictionary = []
File.open("bananagrams_dictionary_caps.txt") do |file|
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
#$letter_pool.pop
#The letter_pool is shuffled so that players will get random letters from the pool
#$letter_pool = $letter_pool.shuffle


#DEFINE CLASSES
#==============


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
    @letter_hash
  end

  def total
    @letters.length
  end


  ###THIS NEXT SECTION NEEDS TO BE DEVELOPED A LOT
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

  #word_to_table is called by the store_word method in the Table class.  On the LetterBag's end, it just updates the @letter_hash
  #so that the letters "on the table" are no longer in the player's bag.
  def word_to_table(word)
    word.each_char do |char|
      @letter_hash[char] -= 1
    end 
  end

  def clear_stored_words
    @used_letters = []
    @used_letter_hash.each_key {|key| @used_letter_hash[key] = 0}
  end

  def print_stored_words
    print @used_letters
    puts ""
  end

  def make_word
    #This method will make a the largest possible  word from the available letters in a player's LetterBag and the player's Table
  end

end

#TODOlist
#Make Table class, each player will have a Table object
#Table encapsulates and enforces all rules about legal states of 2D array
#Table has method for extracting a letter from it and returning it to the LetterBag object so that the LetterBag object can try to make the next word

#Find way to print 2D array of played letters and spaces


#Test playing 1st word, then 2nd word--NEXT SPIKE


class Table
  #This class is a 2D array.
  attr_accessor :size  

  def initialize
    #This should create a 2D array, filling in blank spaces with " "'s or some other space holding character
    #I'm pretty sure we will want this array to always be square... as far as I can tell, Ruby arrays do not have to maintain dimensions the way linear algebra arrays do, so
    #we should implement something that keeps the array square
    @table = [] 
    @size = 0

    #@words is an array of arrays of letters used to make each word on the table... I'm not sure if we need this, but it seems useful for making @table
    @words = []
  end

  def check_table
    #run boggle_type check to ensure that all rules are being followed.  Perform this method each time  store_word is called.
  end

  def print_table
    @table.each {|array| print array.join<<"\n"}
  end

  def store_word(word, bag)
    #This should remove letters from the player's LetterBag and store them in the 2D array
    #word comes from the dictionary, bag is the player's LetterBag object
    @words.push(word.split(//))
    bag.word_to_table(word)
   

 
    check_table
  end

end

player1Table = Table.new


#The word class is used to convert strings into letter_hashes
#Takes string as input
class Word
  attr_accessor :word

  def initialize(word = [])
    @word = word
    @word_hash = Hash.new(0)

    if @word != []
      @word.each_char do |s|
#          puts "I'm making the hash"
          if @word_hash.has_key?(s)
            @word_hash[s] = @word_hash[s] + 1
          else
            @word_hash[s] = 1
          end  
      end
#      puts "I've made the hash"
    end
  end

  def hash
    return @word_hash
  end 

  def show_hash
    @word_hash.each do |key, value|
      puts "#{key} is #{value}"
    end
  end

end



letter_pool_bag = LetterBag.new($letter_pool)
#puts "There are #{$letter_pool.length} letters in the pool."
#puts "There are #{letter_pool_bag.total} letters in the pool."


#test_LB = LetterBag.new(letter_pool_bag.remove_letters(21))
#
#puts "#{test_LB.letters}"
#puts ""
#
#puts "There are #{letter_pool_bag.total} letters in the pool."
#
#puts "I have #{test_LB.total} letters"
#puts "I have:"
#test_hash = test_LB.hash
#test_hash.each {|key, value| puts "#{value} #{key}'s"}
#puts ""
#
#test_LB.peel(letter_pool_bag.remove_letters(1))
#puts "There are #{letter_pool_bag.total} letters in the pool."
#puts "#{test_LB.letters}"
#puts "I have #{test_LB.total} letters"
#puts "I have:"
#test_hash = test_LB.hash
#test_hash.each {|key, value| puts "#{value} #{key}'s"}
#puts ""


player1_bag = LetterBag.new(letter_pool_bag.remove_letters(21))
player1_words = []
#FIGURE OUT HOW TO EFFECTIVELY CHECK THAT player1_bag has all of the required letters in a given word.  Look at 
#make_bananagrams_dictionary.rb for ideas

find_initial_word(player1_bag)
#puts $dictionary
player1_bag.print_stored_words

player1_bag.peel(letter_pool_bag.remove_letters(1))

find_initial_word(player1_bag)
player1_bag.print_stored_words

