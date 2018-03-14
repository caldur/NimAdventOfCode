import math

const puzzleInput = 277678
#var puzzleInput = 1010

type
  Direction = enum
    Right, Top, Left, Bottom
  Ring = object
    edge: int
    data: seq[int]

proc `[]`(ring: Ring, dir: Direction, index: int): int =
  case dir:
    of Right:
      if index == 0:
        return ring.data[ring.data.high]
      elif index <= ring.edge - 1 and index > 0:
        return ring.data[index - 1]
      else:
        return 0
    of Top, Left, Bottom:
      if index <= ring.edge - 1 and index >= 0:
        return ring.data[index + dir.ord * (ring.edge - 1) - 1]
      else:
        return 0

proc sumOfNeighbors(ring: Ring, dir: Direction, index: int): int =
  case dir:
    of Right:
      if index == 0:
        return ring.data[ring.data.high] + ring.data[0]
      elif index == 1:
        return 0
      else:
        return ring.data[ring.data.high]
    of Top, Left:
      if index == 1:
        return ring.data[ring.data.high] + ring.data[ring.data.high - 1]
      else:
        return ring.data[ring.data.high]
    of Bottom:
      if index == 1:
        return ring.data[ring.data.high] + ring.data[ring.data.high - 1]
      elif index == ring.edge - 2:
        return ring.data[ring.data.high] + ring.data[0]
      elif index == ring.edge - 1:
        return ring.data[ring.data.high] + ring.data[0]
      else:
        return ring.data[ring.data.high]

proc add(ring: var Ring, val: int) =
  ring.data.add(val)

#go tackle the problem
var
  currentLevel = 3
  prevRing = Ring(edge: 3, data: @[1, 2, 4, 5, 10, 11, 23, 25])
  n = 0
  currentRing: Ring

block MainLoop:
  while true:
    currentRing = Ring(edge: currentLevel * 2 - 1, data: @[])
    #right
    for i in 0 .. prevRing.edge:
      n = prevRing[Right, i - 1] + prevRing[Right, i] + prevRing[Right, i + 1] + currentRing.sumOfNeighbors(Right, i + 1)
      if n > puzzleInput:
        break MainLoop
      currentRing.add(n)
    # echo currentRing.data
    #top
    for i in 0 .. prevRing.edge:
      n = prevRing[Top, i - 1] + prevRing[Top, i] + prevRing[Top, i + 1] + currentRing.sumOfNeighbors(Top, i + 1)
      if n > puzzleInput:
        break MainLoop
      currentRing.add(n)
    # echo currentRing.data
    #left
    for i in 0 .. prevRing.edge:
      n = prevRing[Left, i - 1] + prevRing[Left, i] + prevRing[Left, i + 1] + currentRing.sumOfNeighbors(Left, i + 1)
      if n > puzzleInput:
        break MainLoop
      currentRing.add(n)
    # echo currentRing.data
    #bottom
    for i in 0 .. prevRing.edge:
      n = prevRing[Bottom, i - 1] + prevRing[Bottom, i] + prevRing[Bottom, i + 1] + currentRing.sumOfNeighbors(Bottom, i + 1)
      if n > puzzleInput:
        break MainLoop
      currentRing.add(n)
    # echo currentRing.data
    #replace old ring with new ring
    prevRing = currentRing
    currentLevel += 1

echo n