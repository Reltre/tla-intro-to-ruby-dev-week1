def my_method(arr)
  arr.uniq!
end

my_arr = [1, 2, 2, 3]
my_method(my_arr)
puts my_arr # => was the outer scope array affected by the method invocation?