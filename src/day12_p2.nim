import sets, strutils
#presumption is that inputs are in order

type TProgram = ref object
  id: int
  groupId: int
  pipes: seq[int]

var programs = newSeq[TProgram]()
var groups = newSeq[HashSet[int]]()

proc aggregate(prog: TProgram, groupId: int, groupSet: var HashSet[int]) =
  #mark program with group id
  prog.groupId = groupId
  #add id to set
  if groupSet.contains(prog.id):
    return
  groupSet.incl(prog.id)
  #recursively include children
  for pipe in prog.pipes:
    programs[pipe].aggregate(groupId, groupSet)


#parse input and store in seq
for line in lines("data/day12_input.txt"):
  var items = line.split(" <-> ")
  var prog = new TProgram
  prog.id = parseInt(items[0])
  prog.groupId = -1
  prog.pipes = newSeq[int]()
  for link in split(items[1], ", "):
    prog.pipes.add(parseInt(link))
  programs.add(prog)

var groupId = 0
#iterate through the programs and collect into objects
for prog in programs:
  #skip if the program has already been add to a group
  if prog.groupId != -1:
    continue
  var grp = initSet[int]()
  prog.aggregate(groupId, grp)
  groupId += 1
  groups.add(grp)

echo groups.len()