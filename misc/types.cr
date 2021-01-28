# assignment 
foo = 5
puts typeof(foo) 
foo = "foo"
puts typeof(foo) 

bar : Int32 | String = 5
puts typeof(bar)
bar = "bar"
puts typeof(bar)

foobar = rand(200000) == 1 ? "foobar" : 5
puts typeof(foobar)
puts foobar + 7 if foobar.is_a?(Int32)

# functions
def say_what(amount)
  amount.times.reduce("") { |t, i| "#{t}What #{i} " }
end

puts say_what(4)

def say_what_again(amount : Int32) : String
  amount.times.reduce("") { |t, i| "#{t}What #{i} " }
end

puts say_what_again(4)

def say_what_again_i_double_dare_you(func : Proc(Int32, Nil))
  func.call(2)
end

say_what_again_i_double_dare_you(->(amount : Int32) {  amount.times{ puts "what" } })

