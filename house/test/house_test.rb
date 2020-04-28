require_relative '../../test_helper'
require_relative '../lib/house'

class OriginalOrderTest < Minitest::Test
  def test_order
    input = ["a", "b", "c", "d", "e"]
    expected = input
    assert_equal expected, OriginalOrderer.new.order(input)
  end
end

class RandomOrdererTest < Minitest::Test
  def test_order
    Random.srand(1)
    input    = ["a", "b", "c", "d", "e"]
    expected = ["c", "b", "e", "a", "d"]
    assert_equal expected, RandomOrderer.new.order(input)
    Random.srand
  end
end

class RandomButLastOrdererTest < Minitest::Test
  def test_order
    Random.srand(1)
    input    = ["a", "b", "c", "d", "always last"]
    expected = ["d", "c", "a", "b", "always last"]
    assert_equal expected, RandomButLastOrderer.new.order(input)
    Random.srand
  end
end

class MixedColumnOrdererTest < Minitest::Test
  def test_order
    Random.srand(1)
    input    = [["a1", "a2"], ["b1", "b2"], ["c1", "c2"], ["d1", "d2"], ["e1", "e2"]]
    expected = [["c1", "a2"], ["b1", "c2"], ["e1", "e2"], ["a1", "d2"], ["d1", "b2"]]
    assert_equal expected, MixedColumnOrderer.new.order(input)
    Random.srand
  end
end


class PhrasesTest < Minitest::Test
  def test_1d_phrase
    input_data = ["phrase 1", "phrase 2", "phrase 3", "phrase 4"]
    expected   = "phrase 2 phrase 3 phrase 4"
    assert_equal expected, Phrases.new(input_data: input_data).phrase(3)
  end

  def test_2d_phrase
    input_data = [["phrase 1a", "1b"], ["phrase 2a", "2b"], ["phrase 3a", "3b"], ["phrase 4a", "4b"]]
    expected   = "phrase 2a 2b phrase 3a 3b phrase 4a 4b"
    assert_equal expected, Phrases.new(input_data: input_data).phrase(3)
  end

  def test_size
    assert_equal 10, Phrases.new(input_data: ["a"] * 10).size
  end
end


class CumulativeTaleTest < Minitest::Test
  attr_reader :tale
  def setup
    @data    = [["phrase 1a", "1b"], ["phrase 2a", "2b"], ["phrase 3a", "3b"], ["phrase 4a", "4b"]]
    @phrases = Phrases.new(input_data: @data)
    @tale = CumulativeTale.new
  end

  def test_line
    expected = "This is phrase 2a 2b phrase 3a 3b phrase 4a 4b.\n"
    assert_equal expected, CumulativeTale.new(phrases: @phrases).line(3)
  end

  def test_recite
    expected =
      "This is phrase 4a 4b.\n" +
      "\n" +
      "This is phrase 3a 3b phrase 4a 4b.\n" +
      "\n" +
      "This is phrase 2a 2b phrase 3a 3b phrase 4a 4b.\n" +
      "\n" +
      "This is phrase 1a 1b phrase 2a 2b phrase 3a 3b phrase 4a 4b.\n"
    assert_equal expected, CumulativeTale.new(phrases: @phrases).recite
  end

  def test_line_1
    expected = "This is the house that Jack built.\n"
    assert_equal expected, tale.line(1)
  end

  def test_line_2
    expected = "This is the malt that lay in the house that Jack built.\n"
    assert_equal expected, tale.line(2)
  end

  def test_line_3
    expected = "This is the rat that ate the malt that lay in the house that Jack built.\n"
    assert_equal expected, tale.line(3)
  end

  def test_line_4
    expected = "This is the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
    assert_equal expected, tale.line(4)
  end

  def test_line_5
    expected = "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
    assert_equal expected, tale.line(5)
  end

  def test_line_6
    expected = "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
    assert_equal expected, tale.line(6)
  end

  def test_line_7
    expected = "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
    assert_equal expected, tale.line(7)
  end

  def test_line_8
    expected = "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
    assert_equal expected, tale.line(8)
  end

  def test_line_9
    expected = "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
    assert_equal expected, tale.line(9)
  end

  def test_line_10
    expected = "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
    assert_equal expected, tale.line(10)
  end

  def test_line_11
    expected = "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
    assert_equal expected, tale.line(11)
  end

  def test_line_12
    expected = "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
    assert_equal expected, tale.line(12)
  end

  def test_all_the_lines
    expected = <<-TEXT
This is the house that Jack built.

This is the malt that lay in the house that Jack built.

This is the rat that ate the malt that lay in the house that Jack built.

This is the cat that killed the rat that ate the malt that lay in the house that Jack built.

This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.

This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.

This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.

This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.

This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.

This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.

This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.

This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    TEXT
    assert_equal expected, tale.recite
  end

end
