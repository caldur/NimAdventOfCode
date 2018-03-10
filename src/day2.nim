import strutils, parseutils

var
  checksum = 0

for line in lines("data/day2_input.txt"):
  var
    min = int.high
    max = 0
  for digit in rsplit(line, Whitespace):
    var n = parseInt(digit)
    if n > max: max = n
    if n < min: min = n
  checksum += (max - min)

echo checksum
