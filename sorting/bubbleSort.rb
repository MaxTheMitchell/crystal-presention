def bubble_sort(list)
  sorted = true
  (list.size - 1).times do |i|
    if list[i] > list[i + 1]
      list[i], list[i + 1] = list[i + 1], list[i]
      sorted = false
    end
  end
  return list if sorted
  bubble_sort(list)
end

INPUT_FILE_NAME = "input.txt"

start_time = Time.now
bubble_sort(File.read("input.txt").split("\n").map { |v| v.to_i })
puts (Time.now - start_time)