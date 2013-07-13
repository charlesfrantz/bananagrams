#!/usr/bin/ruby

require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/BananaNode.rb"


#Need to re-craft BananaGraph into BananaTable.  BananaTable is initialized by the
#longest Word that can be found with the player's initial 21 letters in the LetterBag.


class BananaTable
  attr_accessor :nodes, :xdim, :ydim

  def initialize(first_word) #This only occurs when there are zero tiles on the table... e.g. at beginning of game or if a player wants to start over
    @xdim = first_word.length
    @ydim = 1
    @nodes = get_nodes(first_word) 
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

  def check_table
    #Retrieve would-be words from self. Will want to make this more efficient so that it only checks part of Table that is potentially affected.

    @strings = Array.new
    self.nodes.each do |node|
      word = String.new

      #Get potential word in x direction
      if node.neighbors.find{|neighbor| neighbor.x == node.x-1}.nil? #a node is not the beginning of a would-be word unless this condition and the following condition are met
        unless node.neighbors.find{|neighbor| neighbor.x == node.x+1}.nil?
          self.nodes.find_all{|potential_letter| node.y == potential_letter.y && node.x <= potential_letter.x}.each do |letter_node|
            word<<letter_node.letter
            if letter_node.neighbors.find{|rhNeighbor| rhNeighbor.x == letter_node.x+1}.nil?
              break
            end
          end
          unless word == ""
            @strings.push(word)
            word = String.new
          end
        end
      end
      
      #Get potential word in y direction
      if node.neighbors.find{|neighbor| neighbor.y == node.y-1}.nil?
        unless node.neighbors.find{|neighbor| neighbor.y == node.y+1}.nil?
          self.nodes.find_all{|potential_letter| node.x == potential_letter.x && node.y <= potential_letter.y}.each do |letter_node|
            word<<letter_node.letter
            if letter_node.neighbors.find{|uNeighbor| uNeighbor.y == letter_node.y+1}.nil?
              break
            end
          end
          unless word == ""
            @strings.push(word)
            word = String.new
          end
        end
      end

    end

#    puts "The would-be words in this graph are: "
#    puts(@strings)
    if !(@strings.find{ |word| !word?(word) }.nil?)
#      puts "This graph is invalid"
    else
#      puts "This graph is valid"
    end
#    puts ""

  end

  private
  def get_nodes(first_word)
    nodes = []
    first_word.word.split(//).each_index do |i|
      nodes.push BananaNode.new(i, 0, first_word.word[i])
    end

    #get all neighbor nodes and store in neighbors
    nodes.each do |this|
      unless this.x-1 < 0
        this.neighbors.push(nodes.find { |that| that.x == this.x-1 && that.y == this.y}) unless nodes.find { |that| that.x == this.x-1 && that.y == this.y}.nil?
      end
      unless this.x+1 > self.xdim 
        this.neighbors.push(nodes.find { |that| that.x == this.x+1 && that.y == this.y }) unless nodes.find { |that| that.x == this.x+1 && that.y == this.y}.nil?
      end
    end
  end
    
  def word?(word)
    !$dictionary.dict_array.find{|element| element.word == word}.nil?
  end

end

