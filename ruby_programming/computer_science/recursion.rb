# def append (arr, n)
#   # if n <= 0
#   #   arr.push(0)
#   # else
#   #   append(arr, n-1).push(n)
#   # end
#   if (n <= 0)
#     return arr.push(0)
#   else
#     arr.push(n)
#     append(arr, n-1)
#   end
# end

# p append([], 3) 

#----Code Quizzes ----
#Define a recursive function that finds the factorial of a number.
# def factorial(n)
#   if (n <= 1)
#     return 1
#   else 
#     n * factorial(n-1)
#   end
# end

# p factorial(0)

#Define a recursive function that returns true if a string is a palindrome and false otherwise.
# def palindrome(string)
#   if string.length == 1 || string.length == 0
#     true
#   else
#     if string[0] == string[-1]
#       palindrome(string[1..-2])
#     else
#       false
#     end
#   end
# end

# p is_palindrome("nursesrun")

# Define a recursive function that takes an argument n and prints "n bottles 
# of beer on the wall", "(n-1) bottles of beer on the wall", ..., "no more bottles
# of beer on the wall".

# def beers(n)
#   if n <= 0 
#     puts "no more bottles of beer on the wall"
#   else
#     puts ("#{n} bottles of beer on the wall")
#     beers(n-1)
#   end
# end

# p beers(9)

#Define a recursive function that takes an argument n and returns the fibonacci 
#value of that position. The fibonacci sequence is 0, 1, 1, 2, 3, 5, 8, 13, 21... 
#So fib(5) should return 5 and fib(6) should return 8.

# def fib(n)
#   if n == 0
#     return 0
#   elsif n == 1
#     return 1
#   else
#     fib(n-2) + fib(n-1)
#   end
# end

# p fib(0)

#Define a recursive function that flattens an array. The method should 
#convert [[1, 2], [3, 4]] to [1, 2, 3, 4] and [[1, [8, 9]], [3, 4]] 
#to [1, 8, 9, 3, 4].

# def flatten(array, result = [])
#   array.each do |element|
#     if element.kind_of?(Array
#       flatten(element, result)
#     else
#       result << element
#     end
#   end 
#   result
# end

#Use the roman_mapping hash to define a recursive method that converts an integer
#to a Roman numeral.

# def to_roman(int, str = "")
#     roman_mapping = {
#     1000 => "M",
#     900 => "CM",
#     500 => "D",
#     400 => "CD",
#     100 => "C",
#     90 => "XC",
#     50 => "L",
#     40 => "XL",
#     10 => "X",
#     9 => "IX",
#     5 => "V",
#     4 => "IV",
#     1 => "I"
#   }
#   if (roman_mapping.keys.include?(int))
#     str += roman_mapping[int]
#   else
#     closest = roman_mapping.keys.bsearch {|x| x < int}
#     str += roman_mapping[closest]
#     int -= closest
#     to_roman(int, str)
#   end
# end

# p to_roman(1254)

#Use the roman_mapping hash to define a recursive method that converts a Roman 
#numeral to an integer.

# def roman_to_int(str, int = 0)
#   roman_mapping = {
#   "M" => 1000,
#   "CM" => 900,
#   "D" => 500,
#   "CD" => 400,
#   "C" => 100,
#   "XC" => 90,
#   "L" => 50,
#   "XL" => 40,
#   "X" => 10,
#   "IX" => 9,
#   "V" => 5,
#   "IV" => 4,
#   "I" => 1
#   }
#   if roman_mapping.include?(str)
#     int += roman_mapping[str]
#   else
#     if (roman_mapping.keys.include?(str[0..1]))
#       int += roman_mapping[str[0..1]]
#       roman_to_int(str[2..-1], int)
#     else
#       int += roman_mapping[str[0]]
#       roman_to_int(str[1..-1], int)
#     end
#   end
# end

# p roman_to_int("MCDLIV")

#Write a method #fibs which takes a number and returns that many members 
#of the fibonacci sequence. Use iteration for this solution.

# def fib(n)
#   seq = [0, 1]
#   return [0] if n == 1 
#   return seq if n == 2 
#   3.upto(n) do |num|
#     seq.push(seq[-1] + seq[-2])
#   end
#   seq
# end

# p fib(9)

# # 0, 1, 1, 2, 3, 5, 8, 13, 21

# def fib_rec(n, seq = [0, 1])
#   return [0] if n == 1
#   return seq if n == 2
#   fib_rec(n-1, seq).push(seq[-1] + seq[-2])
# end

# p fib_rec(9)

#Merge Sort