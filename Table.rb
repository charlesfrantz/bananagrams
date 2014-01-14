#!/usr/bin/ruby

require_relative "./BananaNode.rb"

class Table
  attr_reader :middle, :non_nil_nodes
  def initialize(matrix = Array.new(286) { Array.new(286) })
    @nodes = Array.new(matrix.size) {Array.new(matrix.size)}
    @non_nil_nodes = []
    for i in 0...@nodes.size
      for j in 0...@nodes.size
        letter = matrix[i][j]
        @nodes[i][j] = BananaNode.new(i, j)
        set_node(@nodes[i][j], letter)
      end
    end
    for i in 0...@nodes.size
      for j in 0...@nodes.size
        node = @nodes[i][j]
        node.neighbors[:north] = j <= 0 ? nil : @nodes[i][j-1]
        node.neighbors[:east] = i >= @nodes.size - 1 ? nil : @nodes[i+1][j]
        node.neighbors[:south] = j >= @nodes.size - 1 ? nil : @nodes[i][j+1]
        node.neighbors[:west] = i <= 0 ? nil : @nodes[i-1][j]
      end
    end
    @middle = @nodes[@nodes.size/2][@nodes.size/2]
  end

  def set_node(node, letter)
    node.letter = letter
    if letter.nil?
      @non_nil_nodes.delete node
    else
      @non_nil_nodes.push node
    end
  end

  def inspect
    arr = []
    minx = @non_nil_nodes.min{|node1,node2| node1.x <=> node2.x}.x
    maxx = @non_nil_nodes.max{|node1,node2| node1.x <=> node2.x}.x
    miny = @non_nil_nodes.min{|node1,node2| node1.y <=> node2.y}.y
    maxy = @non_nil_nodes.max{|node1,node2| node1.y <=> node2.y}.y

    for y in miny..maxy
      for x in minx..maxx
        col = @nodes[x][y]
        arr.push col.letter.nil? ? ' ' : col.letter
      end
      arr.push("\n")
    end
    arr.join('')
  end

  def print_graph
    puts inspect
  end
end
