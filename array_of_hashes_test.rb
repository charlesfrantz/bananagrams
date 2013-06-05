#!/usr/bin/ruby

$dictionary = ["buts","rats","boobs"]

$dictionary_hash = []
$dictionary.each do |word|
  a = Hash.new(0)
  word.each_char do |s|
    if a.has_key?(s)
      a[s] = a[s] + 1  
    else
      a[s] = 1
    #puts "#{letter}"
    end 
  end
  $dictionary_hash.push(a)
end
puts "#{$dictionary_hash.length}"
