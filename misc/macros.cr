# macro say_method(name, string)
#   def {{name}}(num)
#     num.times { puts {{string}} }
#   end
# end

# say_method say_foo, "foo"
# say_method say_bar, "bar"

# puts say_foo(3)
# puts say_bar(3)


# {% for i in (0..10) %}
#     {% if i < 2 %}
#         FIB_{{i}} = {{i}}
#     {% else %}
#         FIB_{{i}} =  FIB_{{i - 1}} + FIB_{{i - 2}}
#     {% end %}
# {% end %}

# puts(FIB_8)
