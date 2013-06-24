#!/usr/bin/ruby

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

$dictionary = Dictionary.new("bananagrams_dictionary_caps.txt")

class BananaGraph
  attr_reader :nodes

  def initialize(board_arr)
    @nodes = get_nodes(board_arr)
  end

  def solve
    paths = []
    @nodes.each do |die|
      paths = paths + die.all_paths($dictionary.root)
    end
    paths
  end

  def solve_uniq
    solve.uniq { |solution| solution.as_word }
  end

  private
  def get_nodes(board_arr)
    nodes = []
    board_arr.each_index do |i|
      board_arr.each_index do |j|
        nodes.push BananaNode.new(i, j, board_arr[i][j])
      end
    end

    nodes.each do |this|
      ((this.x-1)..(this.x+1)).each do |x|
        ((this.y-1)..(this.y+1)).each do |y|
          unless x < 0 || x >= board_arr.length || y < 0 || y >= board_arr.length || (x==this.x && y==this.y)
            this.neighbors.push(nodes.find { |that| that.x == x && that.y == y })
          end
        end
      end
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

  def all_paths (dict_node, path=BogglePath.new)
    paths = []
    if dict_node.walk! @letter
      path.push self
      if dict_node.terminal? && dict_node.full_state.length > 3
        paths.push path
      end
      (self.neighbors - path.nodes).each do |neighbor|
        paths = paths + neighbor.all_paths(dict_node.clone, path.clone)
      end
    end
    paths
  end

  def to_s
    "{#{self.letter}:[#{self.x},#{self.y}]}"
  end
end


#There are many ways to store the information that needs to be stored in a table
#The main info we need to store is what letters are on the table and at which  coordinate

valid0 = [["B","R","E","A","D"]]
valid1 = [[nil,nil,nil,nil,nil,nil],[nil,"B","R","E","A","D"]]
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

#print_table(valid0)
#puts ""
#print_table(valid1)
#puts ""
#print_table(valid2)
#puts ""
#print_table(valid3)
#puts ""
#print_table(valid4)
#puts ""
#print_table(valid5)
#puts ""
#print_table(valid6)
#puts ""
#print_table(valid7)
#puts ""
#print_table(valid8)
#puts ""

def check_table(array2D)
    

end




