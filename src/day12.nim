import tables, sets, strutils
#presumption is that inputs are in order

var programs = initTable[int, seq[int]]()
var zeroPrograms = initSet[int]()

#parse input
for line in lines("data/day12_input.txt"):
  var items = line.split(" <-> ")
  var links = newSeq[int]()
  var key = parseInt(items[0])
  for link in split(items[1], ", "):
    links.add(parseInt(link))
  programs[key] = links

proc checkNodes(nodes: seq[int]): bool =
  result = false
  for n in nodes:
    if not zeroPrograms.contains(n):
      result = true
      break

var curNodes = programs[0]
while checkNodes(curNodes):
  var l: seq[int] = @[]
  for n in curNodes:
    if not zeroPrograms.contains(n):
      zeroPrograms.incl(n)
      l.add(programs[n])
  curNodes = l

echo zeroPrograms.len() #thought it should also contain 0 but turns not out
echo zeroPrograms