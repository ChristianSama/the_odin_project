class Cypher
  def caesar_cypher(str, key)
    alpha = ('a'..'z').to_a
    encrypted_str = str.split("").map do |el|
      if alpha.include?(el.downcase)
        new_index = alpha.find_index(el.downcase) + key
        if new_index > 25
          new_index = (new_index - 25) - 1
        end
        if el == el.upcase #si es may
          alpha[new_index].upcase
        elsif el == el.downcase  # si es min
          alpha[new_index]
        end
      else
        el
      end
    end
    encrypted_str.join
  end
end