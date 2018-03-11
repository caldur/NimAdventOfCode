import tables, strutils

var registers = initTable[string, int]()

proc evalCondition(reg: var Table[string, int], regName: string, op: string, val: int): bool =
  if not reg.contains(regName):
    reg.add(regName, 0)
  case op:
  of ">":
    result = (reg[regName] > val)
  of "<":
    result = (reg[regName] < val)
  of "<=":
    result = (reg[regName] <= val)
  of ">=":
    result = (reg[regName] >= val)
  of "==":
    result = (reg[regName] == val)
  of "!=":
    result = (reg[regName] != val)
  else:
    discard

proc evalInstruction(reg: var Table[string, int], regName: string, op: string, val: int) =
  if not reg.contains(regName):
    reg.add(regName, 0)
  case op:
  of "inc":
    reg[regName] += val
  of "dec":
    reg[regName] -= val

var max = int.low
for line in lines("data/day8_input.txt"):
  var ins = split(line, Whitespace)
  if registers.evalCondition(ins[4], ins[5], parseInt(ins[6])):
    registers.evalInstruction(ins[0], ins[1], parseInt(ins[2]))


for k, v in registers:
  if v > max:
    max = v

echo max
