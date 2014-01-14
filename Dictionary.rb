#!/usr/bin/ruby

class Dictionary
  attr_reader :dict_hash
  def initialize(words)

    @dict_hash = {}
    words.each do |word|
      @dict_hash[word] = 0
    end
  end
end
