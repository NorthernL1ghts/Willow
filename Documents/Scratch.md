# List of Ideas

1. We need some list of identifiers that are known, ideally with type information as well as the literal value/memory address or something. These need to be scoped (i.e. nested) to allow for shadowing global identifiers within functions for example. This would may even allow us to implement 'let', which would be cool.

[ [ ID -> TYPE ], [ "a" -> integer ] ]

//
// Tree sketch (monospace-aligned):
// ```text
// ROOT: integer(34) + integer(35)
//        ROOT
//       /   +   \
//  integer      integer
//        34          35
//
// ROOT-X: focus is the '+' node (we replace that subtree)
//       ROOT-X
//      /       \
// integer     integer
//      34         35
//
// ROOT-X (after replacement)
//        ?
//      /   |   \
// condition integer integer
//         69       420
// ```