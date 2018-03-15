import tables, sets, strutils

type Node = ref object
  name: string
  weight: int
  tWeight: int
  parent: Node
  children: seq[Node]
  ist2: bool

proc createNode(name: string, weight: int): Node =
  result = new(Node)
  result.name = name
  result.weight = weight
  result.tWeight = weight
  result.parent = nil
  result.children = newSeq[Node]()

proc addChild(node: var Node, child: var Node) =
  node.children.add(child)
  child.parent = node

#parse input, create nodes, and index by name
var allNodes = initTable[string, Node]()
var leafNodes = initSet[string]()
var nodeLinks = initTable[string, seq[string]]()
for line in lines("data/day7_input.txt"):
  var elems = line.split(Whitespace)
  var
    nodeName = elems[0]
    nodeWeight = parseInt(elems[1].substr(1, high(elems[1]) - 1))
  #create node and put into dict
  allNodes[nodeName] = createNode(nodeName, nodeWeight)
  #if node has child(ren), store the link info
  if elems.len() > 2 and elems[2] == "->":
    nodeLinks[nodeName] = elems[3 .. elems.high]
  else:
    leafNodes.incl(nodeName)

#establish the node links
for parentName, childrenNames in nodeLinks:
  var parent = allNodes[parentName]
  for childName in childrenNames:
    #remove trailing comma in children name
    var rn = childName.strip(false, true, {','})
    parent.addChild(allNodes[rn])

#figure out the root node
# var n: Node
# for v in allNodes.values():
#   n = v
#   break
# while n.parent != nil:
#   n = n.parent
# echo n.name

proc getProperWeight(): int =
  var parents = initSet[string]()
  var balanced = true
  while balanced:
    #create list of parent nodes
    for nodeName in leafNodes:
      var parent = allNodes[nodeName].parent
      #tweight is the total weight of the subtree of node
      parent.tWeight += allNodes[nodeName].tWeight
      parents.incl(parent.name)
    #check parent nodes for balance
    for nodeName in parents:
      var p = allNodes[nodeName]
      for n in p.children:
        if n.tWeight != p.children[0].tWeight:
          #correct weight should make the tweights equal
          return p.children[0].tWeight - n.tWeight + n.weight
    #move level
    leafNodes = parents
    parents = initSet[string]()

echo getProperWeight()
