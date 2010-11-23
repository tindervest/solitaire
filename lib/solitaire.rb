$:.unshift File.expand_path("../solitaire", __FILE__)

require 'text_handler'
require 'crypto_service'
require 'deck_cutter'
require 'deck'

module Solitaire
  class Solitaire
  
    def initialize
      @text_handler = TextHandler.new
      @crypto = CryptoService.new
      @deck_cutter = DeckCutter.new
      @deck = Deck.new(@deck_cutter)
    end
    
    def process(message)
      text = @text_handler.processing_input(message)
      data = get_processing_data(text.join)

      if text.join(" ") == message
        output = @crypto.decrypt(data[:message], data[:keystream])
      else
        output = @crypto.encrypt(data[:message], data[:keystream])
      end

      @text_handler.convert_numbers_to_text(output)
    end

    :private
    
    def get_processing_data(message)
      output, keystream = {},""
      @deck.reset
      message.length.times { keystream << @deck.get_next_value }
      output[:message] = @text_handler.convert_text_to_numbers(message)
      output[:keystream] = @text_handler.convert_text_to_numbers(keystream)
      output
    end
  end
end
