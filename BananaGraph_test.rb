#!/usr/bin/ruby
require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/BananaGraph.rb"
require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/Dictionary.rb"
require "/Users/maxfrantz/Desktop/CS Files/GameSolvers/bananagrams/check_table.rb"

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
graph0.print_graph
check_table(graph0)
puts "1:"
graph1.print_graph 
check_table(graph1)
puts "1a:"
graph1a.print_graph #this is broken--prints A island--does not detect that graph is not singular--THIS MAY BE OKAY...
check_table(graph1a)
puts "2:"
graph2.print_graph
check_table(graph2)
puts "3:"
graph3.print_graph
check_table(graph3)
puts "4:"
graph4.print_graph
check_table(graph4)
puts "5:"
graph5.print_graph
check_table(graph5)
puts "6:"
graph6.print_graph
check_table(graph6)
puts "7:"
graph7.print_graph
check_table(graph7)
puts "8:"
graph8.print_graph
check_table(graph8) 
puts "9:"
graph9.print_graph
check_table(graph9)

puts "INVALID GRAPHS"
puts "0:"
invalid_graph0.print_graph
check_table(invalid_graph0)
puts "1:"
invalid_graph1.print_graph
check_table(invalid_graph1)
puts "2:"
invalid_graph2.print_graph 
check_table(invalid_graph2)
puts "3:"
invalid_graph3.print_graph
check_table(invalid_graph3)

