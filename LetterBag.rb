#!/usr/bin/ruby

require_relative "./Word.rb"
#The LetterBag class is used to keep track of how many letters each player has.  It takes an array of chars as input.
#When an object of player's letters is initialized, the call should take the form obj = LetterBag.new($letter_pool.pop(21))
#This will remove 21 letters from $letter_pool AND provide those same 21 letters to the player's LetterBag object
class LetterBag
  attr_accessor  :letter_hash

  #When the LetterBag class is initialized, it creates a hash that stores the number of each letter that each player has
  def initialize(letters = [])
    @letter_hash = Hash.new(0)
    letters.each do |letter|
      if @letter_hash.has_key?(letter)
        @letter_hash[letter] += 1
      else
        @letter_hash[letter] = 1
      end
    end
  end

  #During a "Peel", a new letter is removed from the letter pool array.  It is added to the player's LetterBag object and the hash is updated
  def add(new_letter) #tested, though may want to not have an argument, just take from $letter_pool
    if @letter_hash.has_key?(new_letter)
      @letter_hash[new_letter] += 1
    else
      @letter_hash[new_letter] = 1
    end
  end

  def use(letter)
    @letter_hash[letter] -= 1
  end

  def has?(letter)
    @letter_hash[letter] >= 1
  end

  #During a "Dump", one letter is removed from the player's letterbag and 3 letters are removed from the pool and added to the player's bag
  def dump(dump_letter) #tested 7/2

    #return letter to beginning of $letter_pool
    @letter_hash[dump_letter] -= 1
    $letter_pool.insert(0,dump_letter)

    #pop 3 from $letter_pool into player's bag
    $letter_pool.pop(3).each do |letter|
      if @letter_hash.has_key?(letter)
        @letter_hash[letter] += 1
      else
        @letter_hash[letter] = 1
      end
    end

    #shuffle letter_pool
    $letter_pool.shuffle!
  end

  def has_word?(word)
    Word.new(word).word_hash.all? do |k,v|
      v <= @letter_hash[k]
    end
  end

  def dup
    copy = super
    copy.letter_hash = @letter_hash.dup
    copy
  end

  def to_s
    @letter_hash.to_s
  end
end


