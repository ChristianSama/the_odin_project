def bubble_sort(arr)
  temp = nil
  swapped = nil
  until swapped == false do
    swapped = false
    for i in 0..arr.length-2 do
      if arr[i] > arr[i+1]
        temp = arr[i+1]
        arr[i+1] = arr[i]
        arr[i] = temp
        swapped = true
      end
    end
  end
  arr
end

array = [4,3,2,5,1]
p bubble_sort(array)