#!/usr/bin/ruby

require_relative "./Table.rb"
require_relative "./LetterBag.rb"
require_relative "./Dictionary.rb"

class Player
  attr_reader :table, :bag
  def initialize(pool)
    @table = Table.new
    @dict = Dictionary.new("bananagrams_dictionary_caps.txt").dict_array
    @bag = LetterBag.new(pool)
  end

  def play_word
    if table.middle.letter.nil?
      #play first letter of first word
      @dict.find do |word|
        if @bag.has_word?(word)
          char = word[0]
          @table.set_node(@table.middle, char)
          @bag.use char
        end
      end
    end
    @dict.each do |word|
      @table.non_nil_nodes.each do |node|
        #puts "word:#{word} node:#{node} bag:#{@bag}"
        idxs = (0 .. word.length - 1).find_all { |i| word[i] == node.letter }
        if (idxs.empty?)
          #puts "node letter #{node.letter} not in word #{word}"
        end
        idxs.each do |idx|
          if try_to_build_horiz(node, word, idx)
            return true
          elsif try_to_build_vert(node, word, idx)
            return true
          end
        end
      end
    end
    return false
  end

  private

  def try_to_build_horiz(node, word, idx)
    prefix = word[0...idx]
    suffix = word[idx+1...word.length]
    bag_copy = @bag.dup
    uses_bag_letter = false
    prefix = build_west?(node.west, prefix, bag_copy, uses_bag_letter)
    if (prefix.nil?)
      #puts "prefix is nil"
      return false
    end
    suffix = build_east?(node.east, suffix, bag_copy, uses_bag_letter)
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
    build_horiz(node, prefix, suffix)
  end

  def try_to_build_vert(node, word, idx)
    prefix = word[0...idx]
    suffix = word[idx+1...word.length]
    bag_copy = @bag.dup
    uses_bag_letter = false
    prefix = build_north?(node.north, prefix, bag_copy, uses_bag_letter)
    if (prefix.nil?)
      #puts "vert prefix is nil"
      return false
    end
    suffix = build_south?(node.south, suffix, bag_copy, uses_bag_letter)
    if (suffix.nil?)
      #puts "vert suffix is nil"
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
    build_vert(node, prefix, suffix)
  end

  def build_horiz(node, prefix, suffix)
    west_node = node.west
    prefix.reverse.chars.each do |char|
      unless !west_node.letter.nil?
        @table.set_node(west_node, char)
        @bag.use char
      end
      west_node = west_node.west
    end
    east_node = node.east
    suffix.chars.each do |char|
      unless !east_node.letter.nil?
        @table.set_node(east_node, char)
        @bag.use char
      end
      east_node = east_node.east
    end
  end

  def build_vert(node, prefix, suffix)
    north_node = node.north
    prefix.reverse.chars.each do |char|
      unless !north_node.letter.nil?
        @table.set_node(north_node, char)
        @bag.use char
      end
      north_node = north_node.north
    end
    south_node = node.south
    suffix.chars.each do |char|
      unless !south_node.letter.nil?
        @table.set_node(south_node, char)
        @bag.use char
      end
      south_node = south_node.south
    end
  end

  def build_west?(node, prefix, bag, uses_bag_letter)
    prefix.reverse.chars.each do |char|
      #puts "#{node.letter} != #{char}: #{node.letter != char}"
      #puts "!#{bag}.has?(#{char}): #{!bag.has?(char)}"
      if ((!node.letter.nil? && node.letter != char) || (node.letter.nil? && !bag.has?(char)))
        return nil
      end
      if (vert_conflict?(node, char))
        return nil
      end
      unless node.letter == char
        bag.use char
        #puts "setting uses_bag_letter to true"
        uses_bag_letter = true
      end
      node = node.west
    end
    return prefix
  end

  def build_east?(node, suffix, bag, uses_bag_letter)
    suffix.chars.each do |char|
      #puts "#{node.letter} != #{char}: #{node.letter != char}"
      #puts "!#{bag}.has?(#{char}): #{!bag.has?(char)}"
      if ((!node.letter.nil? && node.letter != char) || (node.letter.nil? && !bag.has?(char)))
        return nil
      end
      if (vert_conflict?(node, char))
        return nil
      end
      unless node.letter == char
        #puts "node: #{node}"
        #puts "char: #{char}"
        bag.use char
        #puts "setting uses_bag_letter to true"
        uses_bag_letter = true
      end
      node = node.east
    end
    return suffix
  end

  def build_north?(node, prefix, bag, uses_bag_letter)
    #puts "build_north? called"
    prefix.reverse.chars.each do |char|
      #puts "#{node.letter} != #{char}: #{node.letter != char}"
      #puts "!#{bag}.has?(#{char}): #{!bag.has?(char)}"
      if ((!node.letter.nil? && node.letter != char) || (node.letter.nil? && !bag.has?(char)))
        #puts "build_north first condition failed"
        return nil
      end
      if (horiz_conflict?(node, char))
        #puts "build_north horiz conflict"
        return nil
      end
      unless node.letter == char
        bag.use char
        uses_bag_letter = true
      end
      node = node.north
    end
    return prefix
  end

  def build_south?(node, suffix, bag, uses_bag_letter)
    suffix.chars.each do |char|
      if ((!node.letter.nil? && node.letter != char) || (node.letter.nil? && !bag.has?(char)))
        return nil
      end
      if (horiz_conflict?(node, char))
        return nil
      end
      unless node.letter == char
        bag.use char
        uses_bag_letter = true
      end
      node = node.south
    end
    return suffix
  end

  def vert_conflict?(node, char)
    node = node.clone
    node.letter = char
    word = vert_word(node)
    if (word.length <= 1 || @dict.include?(word))
      return false
    end
    return true
  end

  def vert_word(node)
    prefix = find_vert_prefix(node)
    suffix = find_vert_suffix(node)
    [prefix, node.letter, suffix].join
  end

  def find_vert_prefix(node)
    if (node.north.letter.nil?)
      return ""
    else
      return node.north.letter + find_vert_prefix(node.north)
    end
  end

  def find_vert_suffix(node)
    if (node.south.letter.nil?)
      return ""
    else
      return node.south.letter + find_vert_prefix(node.south)
    end
  end

  def horiz_conflict?(node, char)
    node = node.clone
    node.letter = char
    word = horiz_word(node)
    if (word.length <= 1 || @dict.include?(word))
      return false
    end
    return true
  end

  def horiz_word(node)
    prefix = find_horiz_prefix(node)
    suffix = find_horiz_suffix(node)
    [prefix, node.letter, suffix].join
  end

  def find_horiz_prefix(node)
    if (node.west.letter.nil?)
      return ""
    else
      return node.west.letter + find_horiz_prefix(node.west)
    end
  end

  def find_horiz_suffix(node)
    if (node.east.letter.nil?)
      return ""
    else
      return node.east.letter + find_horiz_prefix(node.east)
    end
  end

end
