#!/usr/bin/ruby




#Defines the dictionary as an array of words from dictionaryLarge.txt
$dictionary = []
File.open("dictionaryLarge.txt") do |file|
  file.each_line { |line| $dictionary.push line.strip }
end
$dictionary.sort! { |left,right| right.length <=> left.length  }
puts $dictionary.length

#Defines the pool of available letters in a bananagrams game
$letter_pool = []
File.open("letters.txt") do |file|
  file.each_line { |line| $letter_pool.push line.strip }
end
#There is a "" at the end of $letter_pool, so we'll pop it off
$letter_pool.pop


class Word
  attr_accessor :word

  def initialize(word = [])
    @word = word
#    @word_hash = letter_hash
  end

 # def show_string
 #   puts "#{@word}" 
 # end
 
  def return_hash 

    @word_hash = Hash.new(0)
#    puts "WTF?" 
    if @word != []
#    puts "here I am"
      @word.each_char do |s|
#          puts "I'm making the hash"
          if @word_hash.has_key?(s)
            @word_hash[s] = @word_hash[s] + 1
          else
            @word_hash[s] = 1
          end  
      end
#      puts "I've made the hash"
      return @word_hash
    end
  end

  def show_hash
    @word_hash.each do |key, value|
      puts "#{key} is #{value}"
    end
  end

end

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
bad_words = []

$dictionary.each do |element|
  dictionary_word = Word.new(element)
  dictionary_word_hash = dictionary_word.return_hash  
  dictionary_word_hash.each do |key,value|
    if value > $letters[key]
      bad_words.push(element)
      $dictionary.delete(element)
    end
  end
end

puts $dictionary.length

File.open("bananagrams_dictionary.txt",'w') do |line|
  $dictionary.each do |word|
  line.puts word
  end
end

File.open("bad_words.txt",'w') do |line|
  bad_words.each do |word|
  line.puts word
  end
end


#
####### NOW WE NEED TO GO THROUGH THE DICTIONARY ARRAY AND COMPARE EACH ENTRY TO THE LETTER POOL HASH.
####### IF A WORD IN THE DICTIONARY ARRAY HAS TOO MANY OF A CERTAIN LETTER, WE WANT TO DELETE IT FROM THE ARRAY.
####### FINALLY, WE WANT TO WRITE A TXT FILE OF THE UPDATED DICTIONARY WORDS
#$dictionary.each do |word|
#	word.compare_to_pool($letters)
#
#def compare_to_pool(pool_hash)
#  @word = Hash.new(0)
#  
#
#
#end
#
#
#
