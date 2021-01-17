def foo(f)
  puts f.call("foo","bar")
end

def bar(b)
  b + "bar"
end

puts foo(->(a : String, b : String) { (a + b).size } )
