$:.unshift File.expand_path("../../..", __FILE__)

require 'test_helpers'
require 'solitaire/deck'
require 'solitaire/deck_cutter'
require 'mocha'

class DeskTest < Test::Unit::TestCase
 
  def setup
    @deck_cutter = Solitaire::DeckCutter.new
    @deck = Solitaire::Deck.new(@deck_cutter)
  end

  must "contain 54 cards after it is created" do
    assert_equal 54, @deck.cards.count
  end

  must "contain cards in standard order" do
    n = 0
    until n > 51
      assert_equal (n + 1).to_s, @deck.cards[n]
      n = n + 1
    end
  end

  must "be able to return letter value for given numerical value" do
    result = @deck.get_letter_value(1)
    assert_equal 'A', result

    result = @deck.get_letter_value(26)
    assert_equal 'Z', result

    result = @deck.get_letter_value(27)
    assert_equal 'A', result

    result = @deck.get_letter_value(52)
    assert_equal 'Z', result
  end

  must "call DeckCutter::next when getting next output" do 
    Solitaire::DeckCutter.any_instance.expects(:next).with(@deck.cards)
    @deck.get_next_value
  end
  
end
