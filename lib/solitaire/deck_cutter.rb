module Solitaire

  class DeckCutter

    attr_writer :deck

    def next
      move_card('A', 1)
      move_card('B', 2)
      triple_cut
      count_cut
    end

    def move_card(face_value, spots)
      card_index = @deck.index(face_value)
      dest_index = destination_index(card_index, spots)

      @deck.insert(dest_index, @deck.delete_at(card_index))
    end

    def triple_cut
      joker_index = get_joker_indexes

      top_cards = @deck.slice!(0, joker_index[0])
      last_joker_index = joker_index[1] - top_cards.length
      bottom_cards = @deck.slice!(last_joker_index + 1, @deck.length - last_joker_index)

      top_cards.each { |c| @deck.push(c) }
      bottom_cards.reverse!.each { |c| @deck.unshift(c) }
    end

    def count_cut
      number = @deck.last.to_i
      if number > 0
        cut_cards = @deck.slice!(0, number)
        cut_cards << @deck.pop
        cut_cards.each { |c| @deck << c }
      end
    end

    :private

    def destination_index(card_index, spots)
      last_index = @deck.length - 1
      dest_index = card_index + spots

      if dest_index > last_index 
        dest_index = dest_index - last_index 
      end
      dest_index
    end

    def get_joker_indexes
      joker_index = []
      joker_index << @deck.index('A'); joker_index << @deck.index('B')
      joker_index.sort!
    end

  end
end
