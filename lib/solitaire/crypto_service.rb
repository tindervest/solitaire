module Solitaire
  
  class CryptoService

    def encrypt(message, keystream)
      out = []
       message.each_with_index do |value, i|
        combined = value + keystream[i]
        combined > 26 ? out << combined % 26 : out << combined
      end
      out
    end

    def decrypt(message, keystream)
      out = []
      keystream.each_with_index do |value, i|
        messagevalue = message[i]
        combined = messagevalue - value 
        messagevalue <= value ? out << combined + 26 : out << combined
      end
      out
    end
  end

end
