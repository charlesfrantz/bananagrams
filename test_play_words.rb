#!/usr/bin/ruby

require_relative "./Player.rb"

$letter_pool = []
File.open("letters.txt") do |file|
  file.each_line { |line| $letter_pool.push line.strip }
end
$letter_pool.shuffle!
player1 = Player.new($letter_pool.pop(21))
#player1 = Player.new(%w{A B L E L E L H E F})
puts player1.bag
cant_make_word = false
until cant_make_word
  if (player1.play_word)
    player1.table.print_graph
    puts player1.bag
  else
    cant_make_word = true
  end
end
