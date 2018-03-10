import math

const puzzleInput = 277678

proc getSteps(n: int): int =
  #figure out which ring the input is on
  var root = sqrt(n.toFloat)
  var ring = int(root) + 1
  if ring mod 2 == 0:
    ring += 1

  #end number of previous ring
  var start = (ring - 2) ^ 2
  var side = int((n - start) / (ring - 1)) + 1
  var mid = start + (ring - 1) div 2 + (ring - 1) * (side - 1)

  result = abs(n - mid) + (ring - 1) div 2

echo getSteps(puzzleInput)
