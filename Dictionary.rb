#!/usr/bin/ruby

require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/Word"

class Dictionary
  attr_reader :dict_array, :dict_index
  def initialize(filename)
    
    #upload Words into @dict_array
    @dict_array = []
    File.open(filename) do |file|             
      file.each_line { |line| @dict_array.push Word.new(line.strip) }
    end
    
    #sort @dict_array by length, then alphabetically
    @dict_array.sort_by!{|a| [-a.length, a.word]}
    #we now have an array of Words starting with the longest A words and ending with the last 2-letter words

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
