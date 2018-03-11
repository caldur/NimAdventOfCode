import tables, strutils

#dict containing node->parent pair
var nodes = initTable[string, string]()

var key: string
for line in lines("data/day7_input.txt"):
  var index = line.find(" (")
  key = line[0 ..< index]
  index = line.find(" -> ")
  if index != -1:
    for k in split(line.substr(index + 4), ", "):
      if not nodes.contains(k):
        nodes.add(k, key)
      else:
        nodes[k] = key
  if not nodes.contains(key):
    nodes.add(key, nil)

var root = key
while nodes[root] != nil:
  root = nodes[root]

echo root
