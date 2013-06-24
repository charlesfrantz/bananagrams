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

    if @word != []
      @word.each_char do |s|
          if @word_hash.has_key?(s)
            @word_hash[s] = @word_hash[s] + 1
          else
            @word_hash[s] = 1
          end  
      end
    end
  end

end

test_dict = Dictionary.new("bananagrams_dictionary_caps.txt")
test_dict.dict_array[0..10].each do |x|
  print "#{x.word} has \n"
  x.word_hash.each {|k,v| puts "#{v} #{k}'s"}
  puts ""
end


