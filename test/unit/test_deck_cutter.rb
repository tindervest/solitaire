$:.unshift File.expand_path("../../..", __FILE__)

require 'test_helpers'
require 'solitaire/deck_cutter'

class DeckCutterTest < Test::Unit::TestCase

  def setup
    @deck_cutter = Solitaire::DeckCutter.new
    
    @deck = []
    52.times { |n| @deck << (n + 1).to_s }
    @deck << 'A'
    @deck << 'B'

    @deck_cutter.deck = @deck
  end 

  must "move a card down one spot and shift other card" do
    @deck_cutter.move_card('A', 1)
    assert_equal 'A', @deck[53]
    assert_equal 'B', @deck[52]
  end

  must "move a card beyond the end of the deck" do
    @deck_cutter.move_card('A', 2)
    assert_equal '1', @deck[0]
    assert_equal 'A', @deck[1]
    assert_equal '2', @deck[2]
    assert_equal 'B', @deck[53]
  end

  must "perform a triple cut around the two jokers" do
    deck = []
    deck << "1"; deck << "2";  deck << "B"
    49.times { |n| deck << (n + 3).to_s }
    deck << "A"; deck << "52"
  
    @deck_cutter.deck = deck
    @deck_cutter.triple_cut
    assert_equal "52", deck[0]
    assert_equal "B", deck[1]
    49.times { |n| assert_equal (n + 3).to_s, deck[n + 2] }
    assert_equal "A", deck[51]
    assert_equal "1", deck[52]
    assert_equal "2", deck[53]
  end

  must "perform a count cut" do
    deck = []
    deck << "B"
    51.times { |n| deck << (n + 2).to_s }
    deck << "A"
    deck << "1"
    
    @deck_cutter.deck = deck
    @deck_cutter.count_cut
    51.times { |n| assert_equal (n + 2).to_s, deck[n] }
    assert_equal "A", deck[51]
    assert_equal "B", deck[52]
    assert_equal "1", deck[53]
  end

  must "arrange deck as expected when preparing next move " do
    @deck_cutter.next
    51.times { |n| assert_equal (n + 2).to_s, @deck[n] }
    assert_equal "A", @deck[51]
    assert_equal "B", @deck[52]
    assert_equal "1", @deck[53]
  end


end
