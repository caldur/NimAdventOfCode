import strutils

type InstructionList = object
  instructions: seq[int]
  current: int

proc newInstructionList(path: string): InstructionList =
  result = InstructionList(
    instructions: newSeq[int](),
    current: 0
  )
  for line in lines(path):
    result.instructions.add(parseInt(line))

proc jump(il: var InstructionList) =
  var steps = il.instructions[il.current]
  if steps >= 3:
    il.instructions[il.current] -= 1
  else:
    il.instructions[il.current] += 1
  il.current += steps

proc isValid(il: InstructionList): bool =
  (il.current < il.instructions.len) and (il.current >= 0)

when isMainModule:
  var steps = 0
  var list = newInstructionList("data/day5_input.txt")
  #var list = InstructionList(instructions: @[0, 3, 0, 1, -3], current: 0)
  while list.isValid():
    list.jump()
    steps += 1
  echo steps
  #echo list.instructions
