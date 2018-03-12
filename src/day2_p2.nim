import strutils

var
  checksum = 0

proc GetQuotient(vals: seq[int]): int =
  var i, j = 0
  for i in 0 .. vals.high:
    for j in i + 1 .. vals.high:
      if vals[i] >= vals[j]:
        if vals[i] mod vals[j] == 0:
          return vals[i] div vals[j]
      else:
        if vals[j] mod vals[i] == 0:
          return vals[j] div vals[i]

for line in lines("data/day2_input.txt"):
  var list: seq[int] = @[]
  for str in line.split(Whitespace):
    list.add(parseInt(str))
  checksum += GetQuotient(list)

echo checksum
