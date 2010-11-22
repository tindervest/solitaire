module Solitaire

  class TextHandler

    def discard_non_alphabetic(text)
      text.nil? ? "" : text.delete("^A-Z^a-z").upcase
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

    def autofill_array_entries(text_array, size = 5, character = "X")
      if text_array.length > 0
        last_entry = text_array[text_array.length - 1]
        (size - last_entry.length).times { last_entry << character }
      end      
      text_array
    end
  end

end
