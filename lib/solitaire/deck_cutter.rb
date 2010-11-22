module Solitaire

  class DeckCutter

    def next(deck)
      move_card(deck, 'A', 1)
      move_card(deck, 'B', 2)
      triple_cut(deck)
      count_cut(deck)
    end
  
    def move_card(deck, face_value, spots)
      card_index = deck.index(face_value)
      dest_index = destination_index(deck.length, card_index, spots)
      
      deck.insert(dest_index, deck.delete_at(card_index))
    end

    def triple_cut(deck)
      joker_index = get_joker_indexes(deck)

      top_cards = deck.slice(0, joker_index[0])
      bottom_cards = deck.slice(joker_index[1] + 1, deck.length - joker_index[1])

      top_cards.each { |c| deck.delete(c) }
      bottom_cards.each { |c| deck.delete(c) }

      top_cards.each { |c| deck.push(c) }
      bottom_cards.reverse!.each { |c| deck.unshift(c) }
    end

    def count_cut(deck)
      number = deck.last.to_i
      if number > 0
        cut_cards = deck.slice!(0, number)
        cut_cards << deck.pop
        cut_cards.each { |c| deck << c }
      end
    end

    :private

    def destination_index(deck_length, card_index, spots)
      last_index = deck_length - 1
      dest_index = card_index + spots

      if dest_index > last_index 
        dest_index = dest_index - last_index 
      end
      dest_index
    end

    def get_joker_indexes(deck)
      joker_index = []
      joker_index << deck.index('A'); joker_index << deck.index('B')
      joker_index.sort!
    end  

  end
end
