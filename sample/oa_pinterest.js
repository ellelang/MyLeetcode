/*
Suppose we have some input data describing relationships between parents and children over multiple generations. The data is formatted as a list of (parent, child) pairs, where each individual is assigned a unique integer identifier.

For example, in this diagram, 3 is a child of 1 and 2, and 5 is a child of 4:

1   2   4
 \ /   / \
  3   5   8
   \ / \   \
    6   7   9

Write a function that takes this data as input and outputs two collections: one containing all individuals with zero known parents, and one containing all individuals with exactly one known parent.

Sample output:
Zero parents: 1, 2, 4
One parent: 5, 7, 8, 9

*/

var _ = require('underscore');

var parentChildPairs = [
    [1, 3], [2, 3], [3, 6], [5, 6],
    [5, 7], [4, 5], [4, 8], [8, 9]
];



function findParentChild(arr) {
  var zeroParents = [];
  var oneParent = [];
  var node;
  for(var i = 0; i < arr.length; i++) {
    var hasZeroParents = true;

    for(var j = i + 1; j < arr.length; j++) {
      node = arr[i][0];

      if(arr[i][0] === arr[j][1]) {

        if(hasZeroParents === true) {
          hasZeroParents = false;
        }
      }

    }
    //hasZeroParents === true
    if(hasZeroParents === true) {
      zeroParents.push(node);
    }

  }

  console.log(zeroParents)
}

findParentChild(parentChildPairs)
