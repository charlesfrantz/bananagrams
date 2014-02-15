require_relative './Table.rb'
require_relative './Player.rb'
require "test/unit"

class PlayerTest < Test::Unit::TestCase
  def test_play_word_positive_cases
    pool = []
    dictionary = ["AM","ME"]
    table = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, 'M', 'E', nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    expected = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, 'A', nil, nil],
        [nil, nil, 'M', 'E', nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    bag = ['A']
    player = Player.new(pool, dictionary, table, bag)
    player.play_word
    assert_equal(expected.inspect, table.inspect)

    pool = []
    dictionary = ["NY","YE"]
    table = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, 'Y', 'E', nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    expected = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, 'N', nil, nil],
        [nil, nil, 'Y', 'E', nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    bag = ['N']
    player = Player.new(pool, dictionary, table, bag)
    player.play_word
    assert_equal(expected.inspect, table.inspect)

    pool = []
    dictionary = ["ANY","NOR"]
    table = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, 'N', 'O', 'R', nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    expected = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, 'A', nil, nil, nil],
        [nil, 'N', 'O', 'R', nil],
        [nil, 'Y', nil, nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    bag = ['A','Y']
    player = Player.new(pool, dictionary, table, bag)
    player.play_word
    assert_equal(expected.inspect, table.inspect)

    pool = []
    dictionary = ["AND","ANY"]
    table = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, 'A', 'N', 'Y', nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    expected = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, 'A', 'N', 'Y', nil],
        [nil, 'N', nil, nil, nil],
        [nil, 'D', nil, nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    bag = ['N','D']
    player = Player.new(pool, dictionary, table, bag)
    player.play_word
    assert_equal(expected.inspect, table.inspect)

    pool = []
    dictionary = ["AND","ANY"]
    table = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, 'A', 'N', 'Y', nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    expected = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, 'A', nil, nil],
        [nil, 'A', 'N', 'Y', nil],
        [nil, nil, 'D', nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    bag = ['A','D']
    player = Player.new(pool, dictionary, table, bag)
    player.play_word
    assert_equal(expected.inspect, table.inspect)

    pool = []
    dictionary = ["AND","BED"]
    table = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, 'A', 'N', 'D', nil],
        [nil, nil, nil, nil, nil]
    ])
    expected = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, 'B', nil],
        [nil, nil, nil, 'E', nil],
        [nil, 'A', 'N', 'D', nil],
        [nil, nil, nil, nil, nil]
    ])
    bag = ['E','B']
    player = Player.new(pool, dictionary, table, bag)
    player.play_word
    assert_equal(expected.inspect, table.inspect)

    pool = []
    dictionary = ["ANY","DYE"]
    table = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, 'D', 'Y', 'E', nil],
        [nil, nil, nil, nil, nil]
    ])
    expected = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, 'A', nil, nil],
        [nil, nil, 'N', nil, nil],
        [nil, 'D', 'Y', 'E', nil],
        [nil, nil, nil, nil, nil]
    ])
    bag = ['A','N']
    player = Player.new(pool, dictionary, table, bag)
    player.play_word
    assert_equal(expected.inspect, table.inspect)

    pool = []
    dictionary = ["YET","DYE"]
    table = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, 'D', 'Y', 'E', nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    expected = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, 'D', 'Y', 'E', nil],
        [nil, nil, 'E', nil, nil],
        [nil, nil, 'T', nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    bag = ['E','T']
    player = Player.new(pool, dictionary, table, bag)
    player.play_word
    assert_equal(expected.inspect, table.inspect)

    pool = []
    dictionary = ["YET","DYE"]
    table = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, 'D', 'Y', 'E', nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    expected = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, 'Y' , nil],
        [nil, 'D', 'Y', 'E', nil],
        [nil, nil, nil, 'T', nil],
        [nil, nil, nil, nil, nil]
    ])
    bag = ['Y','T']
    player = Player.new(pool, dictionary, table, bag)
    player.play_word
    assert_equal(expected.inspect, table.inspect)

    pool = []
    dictionary = ["YET","ANY"]
    table = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, 'A', 'N', 'Y', nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    expected = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, 'A', 'N', 'Y', nil],
        [nil, nil, nil, 'E', nil],
        [nil, nil, nil, 'T', nil],
        [nil, nil, nil, nil, nil]
    ])
    bag = ['E','T']
    player = Player.new(pool, dictionary, table, bag)
    player.play_word
    assert_equal(expected.inspect, table.inspect)
  end

  def test_play_word_negative_cases
    pool = []
    dictionary = ["AM","ME"]
    table = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, 'M', 'E', nil],
        [nil, nil, 'E', nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    expected = Table.new([
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, 'M', 'E', nil],
        [nil, nil, 'E', nil, nil],
        [nil, nil, nil, nil, nil]
    ])
    bag = ['A']
    player = Player.new(pool, dictionary, table, bag)
    player.play_word
    assert_equal(expected.inspect, table.inspect)
  end
end
