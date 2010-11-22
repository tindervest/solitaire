module Solitaire

  class Deck 

    VALUES = %w{A 2 3 4 5 6 7 8 9 10 J Q K}
    SUITS = %w{clubs diamonds hearts spades}

    attr_reader :cards

    def initialize(cutter)
      @cutter = cutter
      @cards = []
      SUITS.each do |s|
        VALUES.each do |v|
          @cards << get_numerical_value(v, s).to_s
        end
      end
      @cards << 'A'
      @cards << 'B'
    end
    
    def get_next_value
      @cutter.next(@cards)
      index = @cards[0].to_i
      number = @cards[index == 0 ? 53 : index].to_i
      number > 0 ? get_letter_value(number) : get_next_value
    end

    def get_numerical_value(value, suit)
      return 53 if suit == 'joker'
      VALUES.index(value) + (SUITS.index(suit) * 13) + 1 
    end

    def get_letter_value(number_value)
      value = number_value > 26 ? number_value - 26 : number_value
      (value + 64).chr
    end

  end
end
