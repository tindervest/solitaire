$:.unshift File.expand_path("../../../..", __FILE__)

require 'test_helpers'
require 'solitaire/crypto_service'

class CryptoServiceTest < Test::Unit::TestCase
  
  def setup
    @crypto_service = Solitaire::CryptoService.new
  end

  must "combine message and cypher arrays capped at 26 for encryption" do
    message = [16, 26]
    keystream = [10, 1]

    result = @crypto_service.encrypt(message, keystream)

    assert_equal 2, result.length
    assert_equal 26, result[0]
    assert_equal 1, result[1]
  end

  must "combine message and cypher arrays works for decryption" do
    message = [7,12,14,3,17,13,10,1,6,6]
    keystream = [4,23,10,24,8,25,18,6,4,7]

    result = @crypto_service.decrypt(message, keystream)
    assert_equal 10, result.length
    assert_equal 3, result[0]
    assert_equal 15, result[1]
    assert_equal 4, result[2]
    assert_equal 5, result[3]
    assert_equal 9, result[4]
    assert_equal 14, result[5]
    assert_equal 18, result[6]
    assert_equal 21, result[7]
    assert_equal 2, result[8]
    assert_equal 25, result[9]
  end
end
