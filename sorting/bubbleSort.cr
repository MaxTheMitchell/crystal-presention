def bubble_sort(list)
  sorted = true
  (list.size - 1).times do |i|
    if list[i] > list[i + 1]
      tmp = list[i]
      list[i] = list[i + 1]
      list[i + 1] = tmp
      sorted = false
    end
  end
  return list if sorted
  bubble_sort(list)
end

puts Time.measure { bubble_sort(File.read("input.txt").split("\n").map { |v| v.to_i }) }
