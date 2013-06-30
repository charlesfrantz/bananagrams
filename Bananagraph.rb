#!/usr/bin/ruby

require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/BananaNode.rb"

class BananaGraph
  attr_reader :nodes, :xdim, :ydim

  def initialize(board_arr)
    @nodes = get_nodes(board_arr) #Might want to make nodes 2D...
    @xdim = board_arr[0].length
    @ydim = board_arr.length
  end

  private
  def get_nodes(board_arr)
    nodes = []
    board_arr.each_index do |j|
      board_arr[j].each_index do |i|
        nodes.push BananaNode.new(i, j, board_arr[j][i])
      end
    end

    nodes.each do |this|
      ((this.x-1)..(this.x+1)).each do |x|
        ((this.y-1)..(this.y+1)).each do |y|
          unless x < 0 || x >= board_arr[0].length || y < 0 || y >= board_arr.length || (x==this.x && y==this.y) \
          || (x==this.x-1 && y==this.y-1) || (x==this.x+1 && y==this.y+1)|| (x==this.x+1 && y==this.y-1) || (x==this.x-1 && y==this.y+1)
            this.neighbors.push(nodes.find { |that| that.x == x && that.y == y })
          end
        end
      end
    end
    
    #remove nil neighbors--not sure we want to do this...
    nodes.each do |node| 
      node.neighbors.delete_if{|neighbor| neighbor.letter.nil?}
    end
  end
end

