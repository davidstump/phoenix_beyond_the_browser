def calc(value, calculationHandler) do
  calculationHandler.(value)
end

doubleNum = calc(1, fn(num) ->
  num * 2
end)
