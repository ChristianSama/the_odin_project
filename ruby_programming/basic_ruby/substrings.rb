def substrings(str, arr)

  substr_hash = Hash.new(0)
  get_all_substrings(str).each do |el|
    if arr.include?(el.downcase)
      substr_hash[el.downcase] += 1
    end
  end
  substr_hash
end

def get_all_substrings(str)
  substrings = []
  for i in 0..str.length-1 do
    for j in i..str.length-1 do
      substrings.push(str[i..j])
    end
  end
  substrings
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

p substrings("Howdy partner, sit down! How's it going?", dictionary)