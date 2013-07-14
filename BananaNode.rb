#!/usr/bin/ruby


class BananaNode
  attr_reader :x, :y
  attr_accessor :letter, :north, :east, :south, :west

  def initialize(x, y, letter=nil, north=nil, east=nil, south=nil, west=nil)
    @x = x
    @y = y
    @letter = letter
    @north = north
    @east = east
    @south = south
    @west = west
  end

  def to_s
    "{#{self.letter}:[#{self.y},#{self.x}]}"
  end
end
