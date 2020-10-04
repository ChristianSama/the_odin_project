def merge_sort(arr)
  if arr.length > 1
    left = arr[0...arr.length/2]
    right = arr[arr.length/2..-1]
    left = merge_sort(left)
    right = merge_sort(right)
    merge(left, right)
  else
    arr
  end
end

def merge (left, right)
  result = []
  until left.empty? || right.empty? do
    if left[0] < right[0]
      result.push(left.shift)
    elsif
      result.push(right.shift)
    end
  end
  result.concat(left, right)
end

p merge_sort([1, 5, 12, 3, 4, 8])

