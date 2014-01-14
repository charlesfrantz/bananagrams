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

  def initialize(pool, dictionary, table = Table.new, bagLetters=nil)
    @pool = pool
    @dict = Dictionary.new(dictionary).dict_hash
    @table = table
    @bag = LetterBag.new(bagLetters.nil? ? pool.pop(21) : bagLetters)
  end

  def play_word
    peel if @bag.empty?
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
        idxs.each do |idx|
          ORIENTATIONS.each do |orientation|
            if (try_to_build(node, word, idx, orientation))
              return word
            end
          end
        end
      end
    end
    # Couldn't play a word
    dump
    play_word
  end

  def peel
    letter = @pool.pop
    puts "PEELED! Got '#{letter}'"
    @bag.add letter
  end

  def dump
    letter = @bag.pop
    @pool.push(letter).shuffle!
    letters = @pool.pop(3)
    letters.each {|letter| @bag.add letter}
    puts "DUMPED! '#{letter}' for '#{letters.join(',')}'"
  end

  private

  def try_to_build(node, word, idx, orientation)
    prefix = word[0...idx]
    suffix = word[idx+1...word.length]
    bag_copy = @bag.dup
    extended_prefix = build?(node.neighbors[orientation.directions[:backward]], prefix, bag_copy, orientation, :backward)
    if (extended_prefix.nil?)
      #puts "prefix is nil"
      return false
    end
    extended_suffix = build?(node.neighbors[orientation.directions[:forward]], suffix, bag_copy, orientation, :forward)
    if (extended_suffix.nil?)
      #puts "suffix is nil"
      return false
    end

    if (bag_copy.letter_hash.eql? @bag.letter_hash)
      return false
    end

    extended_word = [extended_prefix, node.letter, extended_suffix].join
    unless @dict.include?(extended_word)
      puts "tried to play #{word} but ended up with #{extended_word}"
      return false
    end

    build(node, prefix, suffix, orientation)
  end

  def build?(node, segment, bag, orientation, direction)
    segmentchars = (direction == :backward) ? segment.reverse.chars : segment.chars
    #puts "segmentchars: #{segmentchars}"
    segmentchars.each do |char|
      #puts "#{node.letter} != #{char}: #{node.letter != char}"
      #puts "!#{bag}.has?(#{char}): #{!bag.has?(char)}"
      if ((!node.letter.nil? && node.letter != char) || (node.letter.nil? && !bag.has?(char)))
        return nil
      end
      if (conflict?(node, char, ORIENTATIONS.find {|ori| ori != orientation} ))
        return nil
      end
      unless node.letter == char
        bag.use char
      end
      node = node.neighbors[orientation.directions[direction]]
    end
    extension = find_segment(node, orientation, direction)
    return (direction == :backward) ? extension + segment : segment + extension
  end

  def conflict?(node, char, orientation)
    if node.letter == char
      return false
    end
    node = node.clone
    node.letter = char
    word = find_word(node, orientation)
    if (word.length <= 1 || @dict.include?(word))
      return false
    end
    return true
  end

  def find_word(node, orientation)
    prefix = find_segment(node.neighbors[orientation.directions[:backward]], orientation, :backward)
    suffix = find_segment(node.neighbors[orientation.directions[:forward]], orientation, :forward)
    [prefix, node.letter, suffix].join
  end

  def find_segment_helper(node, orientation, direction)
    if (node.nil? || node.letter.nil?)
      return ""
    else
      return node.letter + find_segment_helper(node.neighbors[orientation.directions[direction]], orientation, direction)
    end
  end

  def find_segment(node, orientation, direction)
    segment = find_segment_helper(node, orientation, direction)
    return (direction == :backward) ? segment.reverse : segment
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

  def fakebuild()
  end
end
