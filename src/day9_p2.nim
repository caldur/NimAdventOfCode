var s = readFile("data/day9_input.txt")

var groups = @[0]

var currentLevel = 0
var isInGarbage = false
var isCancel = false

var garbageCount = 0

for i, c in s:
  if isCancel:
    isCancel = false
    continue
  if isInGarbage:
    if c == '>':
      isInGarbage = false
    elif c == '!':
      isCancel = true
    else:
      garbageCount += 1
    continue
  case c:
    of '{':
      currentLevel += 1
      if currentLevel > (groups.len() - 1):
        groups.add(0)
    of '}':
      groups[currentLevel] += 1
      currentLevel -= 1
    of '<':
      isInGarbage = true
    else:
      discard

# var sum = 0
# for i, n in groups:
#   sum += i * n

echo garbageCount
