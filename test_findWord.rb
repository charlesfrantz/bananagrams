#!/usr/bin/ruby

require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/Dictionary"
require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/LetterBag"

#Test 1--try out find word method
#catt = Word.new("catt")
#batt = Word.new("batt")
#cat = Word.new("cat")
#bat = Word.new("bat")
#
#dict = [batt, catt, bat, cat]
#$bag = {"a"=>1, "b"=>2, "t"=>2, "z"=>1}
#
#valid = dict.find do |word|
#  word.word_hash.all? do |k,v|
#    $bag[k].nil? || v <= $bag[k]
#  end
#end
#
#puts "Test 1"
#puts valid.word
#puts ""

#Test 2--define find word method and test in BananaGrams dictionary

$dictionary = Dictionary.new("bananagrams_dictionary_caps.txt")
$letter_pool = []
File.open("letters.txt") do |file|
  file.each_line { |line| $letter_pool.push line.strip }
end
$letter_pool.shuffle!

#bag1 = LetterBag.new(["H","E","L","L","O"])
bag2 = LetterBag.new(%w{L O H L E L})
#bag3 = LetterBag.new(["H","E","L","L","B"])
#
##could make this faster by searching at the index in $dictionary where LetterBag.length (ie number of letters availalbe) starts
def find_first_word(letterBag)
  $dictionary.dict_array.find do |word|
    word.word_hash.all? do |k,v|
      letterBag.letter_hash[k].nil? || v <= letterBag.letter_hash[k]
    end
  end
end
#
#puts "Test 2"
#puts find_first_word(bag1).word
puts find_first_word(bag2).word
#puts find_first_word(bag3).word


#Test 2--find largest word from initial LetterBag
bag4 = LetterBag.new($letter_pool.pop(21))
bag4.letter_hash.each{|k,v| puts "#{k} is #{v}"}
largest_word = find_first_word(bag4).word
print largest_word
print " is "
print largest_word.length
puts " letters long."

let = $letter_pool.pop
bag4.peel(let)
bag4.letter_hash.each{|k,v| puts "#{k} is #{v}"}
largest_word = find_first_word(bag4).word
print largest_word
print " is "
print largest_word.length
puts " letters long."
