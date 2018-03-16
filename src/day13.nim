import strutils, tables

proc getPos(depth: int, t: int): int =
  var halfCycle = depth - 1
  var ind = (t + 1) mod (2 * halfCycle)
  if ind <= halfCycle:
    return ind
  else:
    return 2 * halfCycle - ind

#parse input
var layers = initTable[int, int]()
var maxLayer = 0
for line in lines("data/day13_input.txt"):
  var elems = line.split(": ")
  var layerId = parseInt(elems[0])
  layers[layerId] = parseInt(elems[1])
  if layerId > maxLayer:
    maxLayer = layerId

#part 1
proc getSeverity(layers: Table[int, int], maxLayer: int): int =
  for t in 0 .. maxLayer:
    if not layers.hasKey(t):
      continue
    if getPos(layers[t], t - 1) == 0:
      result += t * layers[t]

echo getSeverity(layers, maxLayer)

#part 2
proc penetrate(layers: Table[int, int], maxLayer: int, startTime: int): bool =
  for t in 0 .. maxLayer:
    if not layers.hasKey(t):
      continue
    if getPos(layers[t], t - 1 + startTime) == 0:
      return false
  return true

var startTime = 10
while true:
  if penetrate(layers, maxLayer, startTime):
    break
  startTime += 1

echo startTime