$:.unshift File.expand_path("../../..", __FILE__)

require 'test_helpers'
require 'solitaire'

class SolitaireTest < Test::Unit::TestCase

  def setup
    @solitaire = Solitaire::Solitaire.new
  end

  must "be able to encrypt value" do
    result = @solitaire.process("Code in Ruby, live longer")
    assert_equal ["GLNCQ", "MJAFF", "FVOMB", "JIYCB"], result
  end

  must "be able to decrypt value" do
    result = @solitaire.process("CLEPK HHNIY CFPWH FDFEH")
    assert_equal ["YOURC", "IPHER", "ISWOR", "KINGX"], result
  end

end
