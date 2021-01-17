# 1.

# ruby
# foo = [42]
# foo << "foo"
# puts foo.to_s

# crystal
# foo = [4] of (String | Int32)
# foo << "foo"
# puts foo.to_s

# 2.

# def foo(x : (Int32 | Float) ) : String
#     x.to_s
# end

# puts foo(42.0)

@[Link(ldflags: "#{__DIR__}/hello_world.o")]
lib Hello_world
  fun hello(LibC::Char*) : Void
end

Hello_world.hello("moop")
