#!/usr/bin/ruby
require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/Dictionary"

test_dict = Dictionary.new("bananagrams_dictionary_caps.txt")
test_dict.dict_array[-5..-1].each do |x|
  print "#{x.word} has \n"
  x.word_hash.each {|k,v| puts "#{v} #{k}'s"}
  print "#{x.word} is #{x.length} letters long."
  puts ""
end

