#!/usr/bin/ruby

def word?(word)
  !$dictionary.dict_array.find{|element| element.word == word}.nil?
end

