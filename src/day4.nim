import strutils, sets

var n = 0

for line in lines("data/day4_input.txt"):
  var s = initSet[string]()
  var isValid = true
  for word in rsplit(line, Whitespace):
    if s.contains(word):
      isValid = false
      break
    else:
      s.incl(word)
  if isValid: n += 1

echo n
