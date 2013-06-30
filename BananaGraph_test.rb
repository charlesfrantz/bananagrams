#!/usr/bin/ruby
require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/BananaGraph.rb"
require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/Dictionary.rb"

def print_table(array2D)
  array2D.each do |array|
    array.each_index do |ind|
      if array[ind] == nil
        array[ind] = " "
      end
    end
    print array.join<<"\n"
  end
end

def word?(word)
  !$dictionary.dict_array.find{|element| element.word == word}.nil?
end


def check_table(graph)
  #Retrieve would-be words from BananaGraph object. ...There has to be a better way to do this, maybe by storing the word somewhere in the 
  #BananaGraph
  @strings = Array.new
  graph.nodes.each do |node|
    word = String.new
    unless node.letter.nil? 

      #Get potential word in x direction
      unless  !(node.neighbors.find{|neighbor| neighbor.x == node.x-1}.nil?) || node.x == graph.xdim-1
        if !(node.neighbors.find{|neighbor| neighbor.x == node.x+1}.nil?)
          graph.nodes.find_all{|potential_letter| node.y == potential_letter.y && node.x <= potential_letter.x}.each do |letter_node|
            #puts "In x dir"
            if letter_node.letter.nil?
              break
            end
            word<<letter_node.letter
          end
          unless word == ""
            @strings.push(word)
            word = String.new
          end
        end
      end
      
      #Get potential word in y direction
      unless  !(node.neighbors.find{|neighbor| neighbor.y == node.y-1}.nil?) || node.y == graph.ydim-1
        if !(node.neighbors.find{|neighbor| neighbor.y == node.y+1}.nil?)
          graph.nodes.find_all{|potential_letter| node.x == potential_letter.x && node.y <= potential_letter.y}.each do |letter_node|
          #puts "In y dir"
            if letter_node.letter.nil?
              break
            end
            word<<letter_node.letter
          end
          unless word == ""
            @strings.push(word)
            word = String.new
          end
        end
      end

    end
  end

  puts(@strings)
  if !(@strings.find{ |word| !word?(word) }.nil?)
    puts "This graph is invalid"
  else
    puts "This graph is valid"
  end
  puts ""

end

#TEST ARRAYS=====================================================
#================================================================

valid0 = [["B","R","E","A","D"]]
valid1 = [[nil,nil,nil,nil,nil,nil,nil],[nil,"B","R","E","A","D",nil]]
valid1a = [[nil,nil,nil,nil,nil,nil,nil,nil],[nil,"B","R","E","A","D",nil,"A"]]
invalid0 = [[nil,nil,nil,nil,nil,nil],[nil,"D","A","E","R","B"]]
valid2 = [[nil,nil],[nil,"B"],[nil,"R"],[nil,"E"],[nil,"A"],[nil,"D"]]
invalid1 = [[nil,nil],[nil,"D"],[nil,"A"],[nil,"E"],[nil,"R"],[nil,"B"]]
valid3 = [[nil,nil,nil,nil,nil,nil],[nil,"B","R","E","A","D"],[nil,nil,nil,nil,nil,"O"],[nil,nil,nil,nil,nil,"O"],[nil,nil,nil,nil,nil,"R"]]
valid4 = [[nil,nil,nil,nil,nil,"O"],[nil,"B","R","E","A","D"],[nil,nil,nil,nil,nil,"O"],[nil,nil,nil,nil,nil,"R"]]
valid5 = [[nil,nil,"O",nil,nil,nil],[nil,"B","R","E","A","D"],[nil,nil,"D",nil,nil,nil],[nil,nil,"E",nil,nil,nil],[nil,nil,"R",nil,nil,nil]]
valid6 = [[nil,nil,nil,nil,nil,nil],[nil,"B","R","E","A","D"],[nil,nil,nil,nil,"T","O"]]
valid7 = [[nil,nil,nil,nil,"C",nil],[nil,"B","R","E","A","D"],[nil,nil,nil,nil,"T","O"],[nil,nil,nil,nil,"C",nil],[nil,nil,nil,nil,"H",nil]]
invalid2 = [[nil,nil,nil,nil,"C",nil],[nil,"B","R","E","A","D",nil],[nil,nil,nil,nil,"T","I","P"],[nil,nil,nil,nil,"C",nil,nil],[nil,nil,nil,nil,"H",nil,nil]]
valid8 = [[nil,nil,nil,nil,"C",nil],[nil,"B","R","E","A","D",nil],[nil,nil,nil,nil,"T","I","P"],[nil,nil,nil,nil,nil,"M",nil]]
invalid3 = [[nil,nil,nil,nil,"C",nil],[nil,"B","R","E","A","D",nil],[nil,nil,nil,nil,"T","U",nil],[nil,nil,nil,nil,nil,"B",nil]]
valid9 = [[nil,"H","I",nil,"H","I"],[nil,nil,"D","O","E",nil],[nil,nil,nil,nil,"L",nil],[nil,"D","R","O","P",nil]]

graph0 = BananaGraph.new(valid0)
graph1 = BananaGraph.new(valid1)
graph1a = BananaGraph.new(valid1a)
graph2 = BananaGraph.new(valid2)
graph3 = BananaGraph.new(valid3)
graph4 = BananaGraph.new(valid4)
graph5 = BananaGraph.new(valid5)
graph6 = BananaGraph.new(valid6)
graph7 = BananaGraph.new(valid7)
graph8 = BananaGraph.new(valid8)
graph9 = BananaGraph.new(valid9)

invalid_graph0 = BananaGraph.new(invalid0)
invalid_graph1 = BananaGraph.new(invalid1)
invalid_graph2 = BananaGraph.new(invalid2)
invalid_graph3 = BananaGraph.new(invalid3)

#GRAPH TESTS================================
$dictionary = Dictionary.new("bananagrams_dictionary_caps.txt")

puts "VALID GRAPHS"
puts "0:"
check_table(graph0)
puts "1:"
check_table(graph1a)
puts "1a:"
check_table(graph1)
puts "2:"
check_table(graph2)
puts "3:"
check_table(graph3)
puts "4:"
check_table(graph4)
puts "5:"
check_table(graph5)
puts "6:"
check_table(graph6)
puts "7:"
check_table(graph7)
puts "8:"
check_table(graph8)
puts "9:"
check_table(graph9)

check_table(invalid_graph0)
check_table(invalid_graph1)
check_table(invalid_graph2)
check_table(invalid_graph3)

