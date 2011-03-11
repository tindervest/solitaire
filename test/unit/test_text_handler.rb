$:.unshift File.expand_path("../../../..", __FILE__)

require 'test_helpers'
require 'solitaire/text_handler'

class TextHandlerTest < Test::Unit::TestCase
  
  def setup
    @text_handler = Solitaire::TextHandler.new
  end

  must "remove all non alpha characters from text stream and group into array of 5 character strings" do
    text = "Code in Ruby, live longer!"
    assert_equal ["CODEI", "NRUBY", "LIVEL", "ONGER"], @text_handler.processing_input(text)
  end

  must "return an empty string when text stream is nil" do
    assert_equal "", @text_handler.discard_non_alphabetic(nil)
  end

  must "return an array containing groups of 5 characters" do
    text = "CODEINRUBYLIVELONGER"
    result = @text_handler.group_text(text)
    assert_equal 4, result.length
    assert_equal "ONGER", result[3]
  end
 
  must "autofill array entries with X" do
    text = "ABC"
    result = @text_handler.group_text(text)
    assert_equal "ABCXX", result[0]
  end

  must "return array of numbers for string array entry" do
    arr = ["CODEI", "NRUBY", "LIVEL", "ONGER"]
    result = @text_handler.convert_text_to_numbers(arr)
    assert_equal 20, result.length
    assert_equal 3, result[0]
    assert_equal 15, result[1]
    assert_equal 4, result[2]
    assert_equal 5, result[3]
    assert_equal 9, result[4]
  end

  must "return array of numbers for string entry" do
    str = "CODEINRUBYLIVELONGER"
    result = @text_handler.convert_text_to_numbers(str)
    assert_equal 20, result.length
    assert_equal 3, result[0]
    assert_equal 15, result[1]
    assert_equal 4, result[2]
    assert_equal 5, result[3]
    assert_equal 9, result[4]
  end

  must "return array of string given an array of numbers" do
    arr = [7,12,14,3,17,13,10,1,6,6]
    result = @text_handler.convert_numbers_to_text(arr)
    assert_equal 2, result.count
    assert_equal "GLNCQ", result[0]
    assert_equal "MJAFF", result[1]
  end

end
