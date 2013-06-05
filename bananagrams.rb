#!/usr/bin/ruby

require "trie"

$dictionary = []
File.open("dictionaryLarge.txt") do |file|
  file.each_line { |line| $dictionary.push line.strip }
end
$dictionary.sort! { |left,right| right.length <=> left.length  }

$letter_pool = []
File.open("letters.txt") do |file|
  file.each_line { |line| $letter_pool.push line.strip }
end

$my_letters = LetterBag.new($letter_pool.sample(21))

length = $my_letters.length

class LetterBag
  def initialize(letters_arr)
    @letters = Hash.new(0)
    letters_arr.each do |letter|
      if @letters.has? letter
        @letters[letter] = ++@letters[letter]
      end
    end
  end

  def has? (word)
    clone = @letters.clone

  end

  def all_paths (dict_node, path=BogglePath.new)
    paths = []
    if dict_node.walk! @letter
      path.push self
      if dict_node.terminal? && dict_node.full_state.length > 3
        paths.push path
      end
      (self.neighbors - path.nodes).each do |neighbor|
        paths = paths + neighbor.all_paths(dict_node.clone, path.clone)
      end
    end
    paths
  end

  def to_s
    "{#{self.letter}:[#{self.x},#{self.y}]}"
  end
end
