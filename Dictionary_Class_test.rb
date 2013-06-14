#!/usr/bin/ruby


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

test_dict = Dictionary.new("bananagrams_dictionary_caps.txt")
#puts test_dict.dict_array[0..10000]

test_dict.dict_index.each_value do |v|
  puts test_dict.dict_array[v-1]
  puts test_dict.dict_array[v]
  puts test_dict.dict_array[v+1]
  puts ""
end


