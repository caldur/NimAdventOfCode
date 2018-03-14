import strutils, tables

var n = 0

proc isAnagram(a, b: string): bool =
  var
    at = initCountTable[char]()
    bt = initCountTable[char]()
  for c in a:
    at.inc(c)
  for c in b:
    bt.inc(c)

  if at.len != bt.len: return false

  for k, v in at:
    if not bt.hasKey(k): return false
    if v != bt[k]: return false

  return true

for line in lines("data/day4_input.txt"):
  #hash strings by length
  var lenHash = initTable[int, seq[string]]()
  for str in line.split(Whitespace):
    var l = str.len
    if not lenHash.hasKey(l):
      lenHash[l] = @[]
    lenHash[l].add(str)

  #check within each group
  block outer:
    for k, v in lenHash:
      if v.len >= 2:
        for i in 0 ..< v.len:
          for j in i + 1 ..< v.len:
            if isAnagram(v[i], v[j]):
              break outer
    n += 1

echo n
