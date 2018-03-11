import strutils
#input
var params = @[187,254,0,81,169,219,1,190,19,102,255,56,46,32,2,216]

#init list
var list = newSeq[int]()
for i in 0 .. 255:
  list.add(i)
var currentPos = 0
var skipSize = 0

proc Reverse(data: var seq[int], length: int) =
  var numElements = length
  var sub = newSeq[tuple[pos: int, val: int]]()

  for i in currentPos ..< min(currentPos + length, data.len()):
    sub.add((pos: i, val: data[i]))
    numElements -= 1

  if numElements > 0:
    for i in 0 ..< numElements:
      sub.add((pos: i, val: data[i]))

  for i in 0 .. (length div 2) - 1:
    data[sub[i].pos] = sub[length - 1 - i].val
    data[sub[length - 1 - i].pos] = sub[i].val

  currentPos = (currentPos + length + skipSize) mod data.len()
  skipSize += 1

for p in params:
  list.Reverse(p)

echo list[0] * list[1]