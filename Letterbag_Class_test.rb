#!/usr/bin/ruby


class Dictionary
  attr_reader :dict_array, :dict_index
  def initialize(filename)
    
    #upload words into @dict_array
    @dict_array = []
    File.open(filename) do |file|             
      file.each_line { |line| @dict_array.push Word.new(line.strip) }
    end
    
    #sort @dict_array by length, then alphabetically
    @dict_array.sort_by!{|a| [-a.length, a.word]}
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

class Word
  attr_accessor :word
  attr_reader :word_hash, :length

  def initialize(word = [])
    @word = word
    @length = word.length
    @word_hash = Hash.new(0)

    @word.each_char do |s|
      if @word_hash.has_key?(s)
        @word_hash[s] += 1
      else
        @word_hash[s] = 1
      end  
    end
  end

end

$dictionary = Dictionary.new("bananagrams_dictionary_caps.txt")


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
  def initialize(letters = [])
    @letter_hash = Hash.new(0)
    #@letter_hash = Hash[("A".."Z").to_a.map {|letter| [letter,0]}]
    #letters.each {|letter| @letter_hash[letter] += 1}
    letters.each do |letter|
      if @letter_hash.has_key?(letter)
        @letter_hash[letter] += 1
      else
        @letter_hash[s] = 1
      end
    
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
    new_letters = $letter_pool.pop(3)
    new_letters.each {|letter| @letter_hash[letter] +=1}
    #shuffle letter_pool
    $letter_pool.shuffle!
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

#  def to_s
#    self.letter_hash #not sure about this...
#  end


end


def find_largest_word(letterbag)
  $dictionary.dict_array.find do |word|
    letterbag.letter_hash    
  end


end


#TESTS==================================================

test_bag1 = LetterBag.new(["H","E","L","L","O"])
test_bag2 = LetterBag.new($letter_pool.pop(5))
test_bag3 = LetterBag.new(["F","F"])













