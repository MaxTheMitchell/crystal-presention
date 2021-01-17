@[Link(ldflags: "#{__DIR__}/bubbleSort.o")]
lib Sort
  fun bubble_sort(Int32*,Int32) : Int32*
end

puts Time.measure {
    list = File.read("input.txt").split("\n").map { |v| v.to_i }
    Sort.bubble_sort(list,list.size)
}
