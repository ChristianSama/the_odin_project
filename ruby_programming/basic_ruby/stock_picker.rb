def stock_picker(arr)
  best_profit = 0
  best_buy_index = 0
  best_sell_index = 0
  for i in 0..arr.length-1 do
    for j in i..arr.length-1 do
      dif = arr[j] - arr[i]
      #p "#{arr[j]} - #{arr[i]} = #{dif}"
      if (dif > best_profit)
        best_profit = dif 
        best_buy_index = i
        best_sell_index = j
      end
    end
  end
  [best_buy_index, best_sell_index]
end

stocks = [17,3,4,7,1]
p stock_picker(stocks)