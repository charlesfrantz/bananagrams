#!/usr/bin/ruby

#CLASSES AND METHODS==================================================================
#=====================================================================================
class Dictionary
  attr_reader :dict_array, :dict_index
  def initialize(filename)
    
    #upload words into @dict_array
    @dict_array = []
    File.open(filename) do |file|             
      file.each_line { |line| @dict_array.push line.strip }
    end
    
    #sort @dict_array by length, then alphabetically
    @dict_array.sort_by!{|a| [a.length, a]}
    #we now have an array of strings starting with 2-letter A words and ending with the longest word

    #find the indices of @dict_array where a new word length section begins
    @dict_index = Hash.new(0) 
    max = 2
    @dict_array.each do |word|
      if word.length > max
        max = word.length
        @dict_index[word.length] = @dict_array.index(word)
      end 
    end
    
  end
end



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

class BananaNode
  attr_reader :x, :y, :letter
  attr_accessor :neighbors

  def initialize(x, y, letter, neighbors=[])
    @x = x
    @y = y
    @letter = letter
    @neighbors = neighbors
  end

  def to_s
    "{#{self.letter}:[#{self.y},#{self.x}]}"
  end
end

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
  !$dictionary.dict_array.find{|line| line == word}.nil?
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

