import strutils, tables
import day10_p2

proc decodeRow(input: string): string =
  var tmp: seq[string] = @[]
  var hash = KnotHash(input)
  assert hash.len == 32
  for c in hash:
    tmp.add(parseHexInt($c).toBin(4))
  result = tmp.join("")

const input = "hfdlxzhv"
var disk: array[128, string]
var used = 0
for i in 0 .. 127:
  var str = decodeRow(input & "-" & $i)
  disk[i] = str
  for c in str:
    if c == '1':
      used += 1

#answer for part 1
echo used

#part 2
var numRegions = 0
proc markRegion(data: var array[128, string], row, col: int, regSize: var int) =
  #return if cell is outside of disk
  if row < 0 or row > 127 or col < 0 or col > 127:
    return
  #return if cell is unused or occupied
  if data[row][col] != '1':
    return
  #otherwise mark the cell
  data[row][col] = '2'
  regSize += 1
  #and mark all neighouring cells
  data.markRegion(row, col - 1, regSize)
  data.markRegion(row - 1, col, regSize)
  data.markRegion(row, col + 1, regSize)
  data.markRegion(row + 1, col, regSize)

for row in 0 .. 127:
  for col in 0 .. 127:
    var regSize = 0
    disk.markRegion(row, col, regSize)
    if regSize > 0:
      numRegions += 1

echo numRegions
