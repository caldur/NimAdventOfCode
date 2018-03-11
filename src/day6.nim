import strutils, sets

var banks = newSeq[int]()
for n in split(readFile("data/day6_input.txt"), Whitespace):
  if n != "":
    banks.add(parseInt(n))

var patterns = initSet[string]()
var steps = 0

proc findMax(data: seq[int]): int =
  result = 0
  var max = 0
  for i, n in data:
    if n > max:
      result = i
      max = n

proc reallocate(data: var seq[int]) =
  var minIndex = data.findMax()
  var total = data[minIndex]
  data[minIndex] = 0
  var incAll = total div data.len()
  var rem = total mod data.len()
  for i in minIndex + 1 ..< data.len():
    data[i] += incAll
    if rem > 0:
      data[i] += 1
      rem -= 1
  for i in 0 .. minIndex:
    data[i] += incAll
    if rem > 0:
      data[i] += 1
      rem -= 1

patterns.incl(banks.join(","))

while true:
  banks.reallocate()
  steps += 1
  var str = banks.join(",")
  if patterns.contains(str):
    break
  else:
    patterns.incl(str)

echo steps
