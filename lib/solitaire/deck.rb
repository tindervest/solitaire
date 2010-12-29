module Solitaire

  class Deck

    attr_reader :cards

    def initialize(cutter)
      @cutter = cutter
      @cards = []
      reset
    end

    def reset
      @cards.clear
      52.times { |n| @cards << (n + 1).to_s }

      @cards << 'A'
      @cards << 'B'
    end

    def get_next_value
      @cutter.deck = @cards
      @cutter.next
      index = @cards[0].to_i
      number = @cards[index == 0 ? 53 : index].to_i
      number > 0 ? get_letter_value(number) : get_next_value
    end

    def get_letter_value(number_value)
      value = number_value > 26 ? number_value - 26 : number_value
      (value + 64).chr
    end

  end
end
