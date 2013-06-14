#!/usr/bin/ruby

#DEFINE CLASSES
#==============

#The Dictionary class is used to make our dictionary object.  It stores an array of strings, sorted ascending length 
class Dictionary
  attr_reader :dict_array, :dict_index
  def initialize(filename)
    
    #upload words into @dict_array
    @dict_array = []
    File.open(filename) do |file|             
      file.each_line { |line| @dict_array.push line.strip }
    end
    
    #sort @dict_array by length, then alphabetically
    @dict_array.sort_by!{|a| [a.length, a]}
    #we now have an array of strings starting with 2-letter A words and ending with the longest word

    #find the indices of @dict_array where a new word length section begins
    @dict_index = Hash.new(0) 
    max = 2
    @dict_array.each do |word|
      if word.length > max
        max = word.length
        @dict_index[word.length] = @dict_array.index(word)
      end 
    end
    
  end
end


#The LetterBag class is used to keep track of how many letters each player has.  It takes an array of strings of letters as input.
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

  def dump(dump_letter)
    #return letter to beginning of $letter_pool
    @letter_hash[dump_letter] -= 1
    $letter_pool.insert(0,dump_letter)
    #pop 3 from $letter_pool into player's bag
    #shuffle letter_pool
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


#TODOlist
#Make Table class, each player will have a Table object
#Table encapsulates and enforces all rules about legal states of 2D array
#Table has method for extracting a letter from it and returning it to the LetterBag object so that the LetterBag object can try to make the next word

#Find way to print 2D array of played letters and spaces


#Test playing 1st word, then 2nd word--NEXT SPIKE


class Table
  #This class is a 2D array.
  #attr_accessor :size  

  def initialize
    #This should create a 2D array, filling in blank spaces with " "'s or some other space holding character
    #I'm pretty sure we will want this array to always be rectangular...
    # as far as I can tell, Ruby arrays do not have to maintain dimensions the way linear algebra arrays do, so
    #we should implement something that keeps the array rectangular 
    @table = [] 
    #@size = 0

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

#RETRIEVE WORDS AND LETTERS FROM TXT FILES
#=========================================

#Defines the pool of available letters in a bananagrams game.  This object will be kept as an array of strings.
$letter_pool = []
File.open("letters.txt") do |file|
  file.each_line { |line| $letter_pool.push line.strip }
end
#The letter_pool is shuffled so that players will get random letters from the pool
$letter_pool = $letter_pool.shuffle

$dictionary = Dictionary.new("bananagrams_dictionary_caps.txt")



#TEST PROGRAM
#========================================



test_LB = LetterBag.new(["B","A","T","S","K"])
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

