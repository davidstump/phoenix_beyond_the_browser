let numbers = [1, 2, 3]

let sum = numbers.reduce(0) { acc, num in
  acc + num
}

print(sum) #=> 6
