require_relative "./Word.rb"

class LetterBag
  attr_accessor  :letter_hash

  #When the LetterBag class is initialized, it creates a hash that stores the number of each letter that each player has
  def initialize(letters = [])
    @letter_hash = Hash.new(0)
    letters.each do |letter|
      add letter
    end
  end

  def add(new_letter)
    @letter_hash[new_letter] += 1
  end

  def use(letter)
    @letter_hash[letter] -= 1
  end

  def has?(letter)
    @letter_hash[letter] >= 1
  end

  def has_word?(word)
    Word.new(word).word_hash.all? do |k,v|
      v <= @letter_hash[k]
    end
  end

  def dup
    copy = super
    copy.letter_hash = @letter_hash.dup
    copy
  end

  def to_s
    to_a.join('')
  end

  def pop
    letter = to_a.pop
    use(letter)
    letter
  end

  def empty?
    to_a.empty?
  end

  private
  def to_a
    @letter_hash.to_a.map {|x| x.reduce(:*)}.join('').split('')
  end
end


