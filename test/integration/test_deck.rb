$:.unshift File.expand_path("../../../..", __FILE__)

require 'test_helpers'
require 'solitaire/deck_cutter'
require 'solitaire/deck'

class DeckIntegrationTest < Test::Unit::TestCase

  def setup
    @cutter = Solitaire::DeckCutter.new
    @deck   = Solitaire::Deck.new(@cutter)
  end

  must "be able to generate first 10 letters" do
    assert_equal "D", @deck.get_next_value
    assert_equal "W", @deck.get_next_value
    assert_equal "J", @deck.get_next_value
    assert_equal "X", @deck.get_next_value
    assert_equal "H", @deck.get_next_value
    assert_equal "Y", @deck.get_next_value
    assert_equal "R", @deck.get_next_value
    assert_equal "F", @deck.get_next_value
    assert_equal "D", @deck.get_next_value
    assert_equal "G", @deck.get_next_value
  end
end
