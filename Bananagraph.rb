#!/usr/bin/ruby

require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/BananaNode.rb"

class BananaGraph
  attr_reader :nodes, :xdim, :ydim

  def initialize(board_arr)
    @xdim = board_arr[0].length
    @ydim = board_arr.length
    @nodes = get_nodes(board_arr) #Might want to make nodes 2D...
  end

  def print_graph
    for j in 0..@ydim
      for i in 0..@xdim
        if @nodes.find{|node| node.x == i && node.y == j }.nil? && i == @xdim
          puts " "
        elsif @nodes.find{|node| node.x == i && node.y == j }.nil? 
          print " "
        else
          if i == @xdim
            puts @nodes.find{|node| node.x == i && node.y == j}.letter
          else
            print @nodes.find{|node| node.x == i && node.y == j}.letter
          end
        end
      end
    end
  end

  private
  def get_nodes(board_arr)
    nodes = []
    board_arr.each_index do |j|
      board_arr[j].each_index do |i|
        unless board_arr[j][i].nil?
          nodes.push BananaNode.new(i, j, board_arr[j][i])
        end
      end
    end

    #get all neighbor nodes and store in neighbors
    nodes.each do |this|
      unless this.x-1 < 0
        this.neighbors.push(nodes.find { |that| that.x == this.x-1 && that.y == this.y}) unless nodes.find { |that| that.x == this.x-1 && that.y == this.y}.nil?
      end
      unless this.x+1 > self.xdim 
        this.neighbors.push(nodes.find { |that| that.x == this.x+1 && that.y == this.y }) unless nodes.find { |that| that.x == this.x+1 && that.y == this.y}.nil?
      end
      unless this.y-1 < 0
        this.neighbors.push(nodes.find { |that| that.x == this.x && that.y == this.y-1 }) unless nodes.find { |that| that.x == this.x && that.y == this.y-1}.nil?
      end
      unless this.y+1 > self.ydim
        this.neighbors.push(nodes.find { |that| that.x == this.x && that.y == this.y+1 }) unless nodes.find { |that| that.x == this.x && that.y == this.y+1}.nil?
      end
    end
    
  end
end

