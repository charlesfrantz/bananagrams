#!/usr/bin/ruby

class BananaNode
  attr_reader :x, :y
  attr_accessor :letter, :neighbors

  def initialize(x, y, letter=nil, neighbors = {})
    @x = x
    @y = y
    @letter = letter
    @neighbors = neighbors
  end

  def to_s
    "{#{self.letter}:[#{self.y},#{self.x}]}"
  end
end
