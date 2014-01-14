#!/usr/bin/ruby

require_relative "./Player.rb"

dictionary_file = ARGV.length > 0 ? ARGV[0] : "dictionary.txt"
dictionary = []
File.open(dictionary_file) do |file|
  file.each do |line|
    dictionary.push line.strip
  end
end
letters = ARGV.length > 1 ? ARGV[1] : "letters.txt"

$letter_pool = []
File.open(letters) do |file|
  file.each_line { |line| $letter_pool.push line.strip }
end
$letter_pool.shuffle!
player1 = Player.new($letter_pool, dictionary)
puts "Letters remaining: #{player1.bag}"
begin
  cant_make_word = false
  until cant_make_word
    if (player1.play_word)
      player1.table.print_graph
      puts "Letters remaining: #{player1.bag}"
    else
      cant_make_word = true
    end
  end
end while player1.dump

