#!/usr/bin/ruby

class Word
  attr_accessor :word
  attr_reader :word_hash, :length

  def initialize(word = String.new)
    @word = word
    @length = word.length
    @word_hash = Hash.new(0)

    if @word != []
      @word.each_char do |s|
          if @word_hash.has_key?(s)
            @word_hash[s] += 1
          else
            @word_hash[s] = 1
          end  
      end
    end

  end

end
