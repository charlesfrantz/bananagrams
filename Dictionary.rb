#!/usr/bin/ruby

class Dictionary
  attr_reader :dict_hash
  def initialize(filename)

    #upload Words into @dict_array
    @dict_hash = {}
    File.open(filename) do |file|
      file.each_line { |line| @dict_hash[line.strip] = 0 }
    end
  end
end
