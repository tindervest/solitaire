module Solitaire

  class TextHandler

    def processing_input(text)
      output = discard_non_alphabetic(text)
      group_text(output)
    end

    def group_text(text)
      out, current = [],[]
      text.chars do |c|
        current << c
        if current.length == 5
          out << current.join
          current.clear
        end
      end
      out << current.join unless current.length == 0
      autofill_array_entries(out)
    end

    def convert_text_to_numbers(text)
      out = []
      str = text.respond_to?(:join) ? text.join : text
      str.chars { |c| out << c.ord - 64 }
      out
    end

    def convert_numbers_to_text(numbers)
      str = ""
      numbers.each { |n| str << (n + 64).chr }
      group_text(str)
    end

    :private 

    def discard_non_alphabetic(text)
      text.nil? ? "" : text.delete("^A-Z^a-z").upcase
    end

    def autofill_array_entries(text_array, size = 5, character = "X")
      (size - text_array.last.length).times { text_array.last << character } unless text_array.last.nil?
      text_array
    end
  end

end
