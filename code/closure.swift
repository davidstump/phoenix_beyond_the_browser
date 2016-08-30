func calc(num: Int, calcHandler: Int -> Int) -> Int { 
  return calcHandler(num)
}

let doubleNum = calc(1) { num in 
  num * 2
}
