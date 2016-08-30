numbers = [1, 2, 3]
sum = Enum.reduce(numbers, 0, fn (num, acc) ->
    acc + num
end) 
IO.puts(sum) #=> 6
