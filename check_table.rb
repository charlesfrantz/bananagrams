#!/usr/bin/ruby
require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/word?.rb"

def check_table(graph)
  #Retrieve would-be words from BananaGraph object. ...There has to be a better way to do this, maybe by storing the word somewhere in the 
  #BananaGraph

  @strings = Array.new
  graph.nodes.each do |node|
    word = String.new

    #Get potential word in x direction
    if node.neighbors.find{|neighbor| neighbor.x == node.x-1}.nil?
      unless node.neighbors.find{|neighbor| neighbor.x == node.x+1}.nil?
        graph.nodes.find_all{|potential_letter| node.y == potential_letter.y && node.x <= potential_letter.x}.each do |letter_node|
          #puts "In x dir"
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
        graph.nodes.find_all{|potential_letter| node.x == potential_letter.x && node.y <= potential_letter.y}.each do |letter_node|
          #puts "In y dir"
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

  puts "The would be words in this graph are: "
  puts(@strings)
  if !(@strings.find{ |word| !word?(word) }.nil?)
    puts "This graph is invalid"
  else
    puts "This graph is valid"
  end
  puts ""

end
