#!/usr/bin/ruby

require_relative "./Table.rb"
require_relative "./LetterBag.rb"
require_relative "./Dictionary.rb"
require_relative "./Orientation.rb"

class Player
  attr_reader :table, :bag
  HORIZ = Orientation.new
  VERT = Orientation.new(false)
  ORIENTATIONS = [HORIZ, VERT]

  def initialize(pool)
    @table = Table.new
    @dict = Dictionary.new("bananagrams_dictionary_caps.txt").dict_hash
    @bag = LetterBag.new(pool)
  end

  def play_word
    if table.middle.letter.nil?
      #play first letter of first word
      @dict.keys.find do |word|
        if @bag.has_word?(word)
          char = word[0]
          @table.set_node(@table.middle, char)
          @bag.use char
        end
      end
    end
    @dict.each_key do |word|
      @table.non_nil_nodes.each do |node|
        #puts "word:#{word} node:#{node} bag:#{@bag}"
        idxs = (0 .. word.length - 1).find_all { |i| word[i] == node.letter }
        if (idxs.empty?)
          #puts "node letter #{node.letter} not in word #{word}"
        end
        idxs.each do |idx|
          ORIENTATIONS.each do |orientation|
            if (try_to_build(node, word, idx, orientation))
              return true
            end
          end
        end
      end
    end
    return false
  end

  private


  def try_to_build(node, word, idx, orientation)
    prefix = word[0...idx]
    suffix = word[idx+1...word.length]
    bag_copy = @bag.dup
    prefix = build?(node.neighbors[orientation.directions[:backward]], prefix, bag_copy, orientation, :backward)
    if (prefix.nil?)
      #puts "prefix is nil"
      return false
    end
    suffix = build?(node.neighbors[orientation.directions[:forward]], suffix, bag_copy, orientation, :forward)
    if (suffix.nil?)
      #puts "suffix is nil"
      return false
    end
    word = [prefix, node.letter, suffix].join
    if (!@dict.include?(word))
      #puts "#{word} is not a word"
      return false
    end
    if (bag_copy.letter_hash.eql? @bag.letter_hash)
      #puts "doesn't use bag letter"
      return false
    end
    #puts "bag_copy: #{bag_copy}"
    #puts "bag     : #{@bag}"
    build(node, prefix, suffix, orientation)
  end

  def build?(node, segment, bag, orientation, direction)
    segmentchars = (direction == :backward) ? segment.reverse.chars : segment.chars
    #puts "segmentchars: #{segmentchars}"
    segmentchars.each do |char|
      #puts "#{node.letter} != #{char}: #{node.letter != char}"
      #puts "!#{bag}.has?(#{char}): #{!bag.has?(char)}"
      if ((!node.letter.nil? && node.letter != char) || (node.letter.nil? && !bag.has?(char)))
        #puts "first build? condition failed"
        return nil
      end
      if (conflict?(node, char, ORIENTATIONS.find {|ori| ori != orientation} ))
        #puts "build? conflict"
        return nil
      end
      unless node.letter == char
        bag.use char
        #puts "setting uses_bag_letter to true"
        uses_bag_letter = true
      end
      node = node.neighbors[orientation.directions[direction]]
    end
    return segment
  end

  def conflict?(node, char, orientation)
    node = node.clone
    node.letter = char
    word = find_word(node, orientation)
    if (word.length <= 1 || @dict.include?(word))
      return false
    end
    return true
  end

  def find_word(node, orientation)
    prefix = find_segment(node, orientation, :backward)
    suffix = find_segment(node, orientation, :forward)
    [prefix, node.letter, suffix].join
  end

  def find_segment(node, orientation, direction)
    if (node.neighbors[orientation.directions[direction]].letter.nil?)
      return ""
    else
      return node.neighbors[orientation.directions[direction]].letter + find_segment(node.neighbors[orientation.directions[direction]], orientation, direction)
    end
  end

  def build(node, prefix, suffix, orientation)
    back_node = node.neighbors[orientation.directions[:backward]]
    prefix.reverse.chars.each do |char|
      unless !back_node.letter.nil?
        @table.set_node(back_node, char)
        @bag.use char
      end
      back_node = back_node.neighbors[orientation.directions[:backward]]
    end
    for_node = node.neighbors[orientation.directions[:forward]]
    suffix.chars.each do |char|
      unless !for_node.letter.nil?
        @table.set_node(for_node, char)
        @bag.use char
      end
      for_node = for_node.neighbors[orientation.directions[:forward]]
    end
  end
end
