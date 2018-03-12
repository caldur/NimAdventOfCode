import strutils

var s = readFile("data/day1_input.txt")

var
  sum: int = 0
  base = '0'.ord

var top = (s.high - 1) div 2
for i in 0 .. top:
  if s[i] == s[i + top + 1]:
    sum += 2 * (s[i].ord - base)

echo sum