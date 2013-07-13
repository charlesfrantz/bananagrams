#!/usr/bin/ruby

require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/Dictionary"
require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/BananaGraph"
require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/check_table"
require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/LetterBag"

bag1 = LetterBag.new(["H","E","L","L","B"])
bag1.letter_hash.each {|k,v| puts "#{k} has #{v}"}
