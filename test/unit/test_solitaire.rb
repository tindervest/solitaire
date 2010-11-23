$:.unshift File.expand_path("../../../..", __FILE__)

require "test_helpers"
require "solitaire"
require "mocha"

class SolitaireTest < Test::Unit::TestCase

  def setup
    @solitaire = Solitaire::Solitaire.new
    Solitaire::Deck.any_instance.stubs(:get_next_value).returns("D", "W", "J", "X", "H", "Y", "R", "F", "D", "G")
  end
  
  must "call CryptoService::encrypt when lowercase letters are included in argument" do
    message = "testx"
    Solitaire::TextHandler.any_instance.stubs(:processing_input).with(message).returns(["TESTX"])
    Solitaire::TextHandler.any_instance.stubs(:convert_text_to_numbers).with("TESTX").returns([1,2,3,4,5])
    Solitaire::TextHandler.any_instance.stubs(:convert_text_to_numbers).with("DWJXH").returns([5,4,3,2,1])
    Solitaire::TextHandler.any_instance.stubs(:convert_numbers_to_text).with([1,2,3,4,5]).returns(["ABCDE"])

    Solitaire::CryptoService.any_instance.expects(:encrypt).with([1,2,3,4,5], [5,4,3,2,1]).returns([1,2,3,4,5])

    @solitaire.process(message)
  end

  must "call CryptoService::decrypt when all uppercase letters grouped by 5 characters and completed with X" do
    message = "ASBVS YHNSX"
    Solitaire::TextHandler.any_instance.stubs(:processing_input).with(message).returns(["ASBVS", "YHNSX"])
    Solitaire::TextHandler.any_instance.stubs(:convert_text_to_numbers).with("ASBVSYHNSX").returns([1,2,3,4,5,6,7,8,9,10])
    Solitaire::TextHandler.any_instance.stubs(:convert_text_to_numbers).with("DWJXHYRFDG").returns([10,9,8,7,6,5,4,3,2,1])
    Solitaire::TextHandler.any_instance.stubs(:convert_numbers_to_text).with([1,2,3,4,5,6,7,8,9,10]).returns(["ABCDEFGHIJ"])
    
    Solitaire::CryptoService.any_instance.expects(:decrypt).with([1,2,3,4,5,6,7,8,9,10], [10,9,8,7,6,5,4,3,2,1]).returns([1,2,3,4,5,6,7,8,9,10])

    @solitaire.process(message)
  end

end
