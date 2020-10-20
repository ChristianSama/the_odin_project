class Calculator
  def add(*params)
    sum = 0
    params.each do |el|
      sum += el
    end
    sum
  end
  def subtract(a, b)
    a - b
  end
end

calc = Calculator.new

p calc.add(2, 5, 3, 6)