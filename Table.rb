#!/usr/bin/ruby

require_relative "./BananaNode.rb"

class Table
  attr_reader :middle, :non_nil_nodes
  DIMENSION = 286
  def initialize
    @nodes = Array.new(DIMENSION) { Array.new(DIMENSION) }
    for i in 0...DIMENSION
      for j in 0...DIMENSION
        @nodes[i][j] = BananaNode.new(i, j)
      end
    end
    for i in 0...DIMENSION
      for j in 0...DIMENSION
        node = @nodes[i][j]
        node.north = j <= 0 ? nil : @nodes[i][j-1]
        node.east = i >= DIMENSION - 1 ? nil : @nodes[i+1][j]
        node.south = j >= DIMENSION - 1 ? nil : @nodes[i][j+1]
        node.west = i <= 0 ? nil : @nodes[i-1][j]
      end
    end
    @middle = @nodes[DIMENSION/2][DIMENSION/2]
    @non_nil_nodes = []
  end

  def set_node(node, letter)
    node.letter = letter
    if letter.nil?
      @non_nil_nodes.delete node
    else
      @non_nil_nodes.push node
    end
  end

  def print_graph
    minx = @non_nil_nodes.min{|node1,node2| node1.x <=> node2.x}.x
    maxx = @non_nil_nodes.max{|node1,node2| node1.x <=> node2.x}.x
    miny = @non_nil_nodes.min{|node1,node2| node1.y <=> node2.y}.y
    maxy = @non_nil_nodes.max{|node1,node2| node1.y <=> node2.y}.y

    for y in miny..maxy
      for x in minx..maxx
        col = @nodes[x][y]
        print col.letter.nil? ? " " : col.letter
      end
      puts
    end
  end

end
