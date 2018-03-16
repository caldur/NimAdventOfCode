import strutils

var moves = readFile("data/day11_input.txt").split(',')
#remove the newline at the end of the alst move
var last = moves.len() - 1
moves[last] = moves[last].substr(0, moves[last].len - 2)

proc getStep(x, y: int): int =
  var ySteps = 0
  #moving n grids e/w allows y movement of at most roundup(x / 2) grids
  var yRange = (x.abs() + 1) div 2
  if y.abs() > yRange:
    #additional y movement is necessary only if yoffset is out of covered range
    ySteps = y.abs() - yRange
  result = x.abs() + ySteps

var
  x, y = 0
  maxStep = 0
for m in moves:
  case m:
    of "n":
      y += 1
    of "s":
      y -= 1
    of "ne":
      x += 1
      y += 1
    of "se":
      x += 1
      y -= 1
    of "nw":
      x -= 1
      y += 1
    of "sw":
      x -= 1
      y -= 1
    else:
      discard
  var s = getStep(x, y)
  if s > maxStep:
    maxStep = s

echo maxStep