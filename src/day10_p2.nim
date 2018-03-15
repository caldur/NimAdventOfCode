import strutils, sequtils, strformat
#input
var input = "187,254,0,81,169,219,1,190,19,102,255,56,46,32,2,216"

proc Reverse(data: var seq[int], length: int, currentPos: var int, skipSize: var int) =
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

proc KnotHash(input: string): string =
  #convert input into length seq
  var lengths = newSeq[int]()
  for c in input:
    lengths.add(c.ord)
  lengths.add([17, 31, 73, 47, 23])
  #init the lists
  var list = newSeq[int]()
  for i in 0 .. 255:
    list.add(i)
  #init counters
  var currentPos = 0
  var skipSize = 0
  #do 64 rounds of hash
  for i in 1 .. 64:
    for param in lengths:
      list.Reverse(param, currentPos, skipSize)
  #xor the sparse hashes
  var output: seq[int] = @[]
  for i in 1 .. 16:
    var start = (i - 1) * 16
    var val = 0
    for j in start .. start + 15:
      val = val xor list[j]
    output.add(val)
  #finalize output
  echo output
  var s = map(output) do (x: int) -> string: fmt"{x:x}"
  result = s.join()

echo KnotHash(input)