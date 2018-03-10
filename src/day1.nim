var s = readFile("data/day1_input.txt")

var
  sum: int = 0
  base: int = '0'.ord
  currentDigit: int = s[s.len - 2].ord - base

for i in countdown(s.len - 2, 0):
  var digit = s[i].ord - base
  if digit != currentDigit:
    currentDigit = digit
  else:
    sum += digit

echo sum
