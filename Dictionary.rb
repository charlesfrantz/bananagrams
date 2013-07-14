#!/usr/bin/ruby

class Dictionary
  attr_reader :dict_array
  def initialize(filename)

    #upload Words into @dict_array
    @dict_array = []
    File.open(filename) do |file|
      file.each_line { |line| @dict_array.push line.strip }
    end
  end
end
