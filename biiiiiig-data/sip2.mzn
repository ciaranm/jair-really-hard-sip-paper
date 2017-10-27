include "globals.mzn";

int: maxL = 127;

int: p;
array[1..p] of 0..maxL: patternLabels;
array[1..p, 1..p] of 0..1: patternAdj;

int: t;
array[1..t] of 0..maxL: targetLabels;
array[1..t, 1..t] of 0..1: targetAdj;

array[1..p] of int: patternDegree = [ sum (w in 1..p)(patternAdj[v, w]) | v in 1..p ];

array[1..p, 0..maxL] of int: patternAdjLabels = array2d(1..p, 0..maxL,
    [ sum (w in 1..p where patternLabels[w] = l)(patternAdj[v, w]) | v in 1..p, l in 0..maxL ]);
array[1..t, 0..maxL] of int: targetAdjLabels = array2d(1..t, 0..maxL,
    [ sum (w in 1..t where targetLabels[w] = l)(targetAdj[v, w]) | v in 1..t, l in 0..maxL ]);

array[1..p] of var 1..t: mapping;

constraint alldifferent(mapping);

constraint forall (
    v1 in 1..p,
    v2 in 1..p,
    w1 in 1..t,
    w2 in 1..t
    where patternAdj[v1, v2] == 1 /\ targetAdj[w1, w2] == 0)
    (mapping[v1] != w1 \/ mapping[v2] != w2);

constraint forall (
    v in 1..p,
    w in 1..t
    where patternLabels[v] != targetLabels[w])
    (mapping[v] != w);

constraint forall (
    v in 1..p,
    w in 1..t,
    l in 0..maxL
    where patternAdjLabels[v, l] > targetAdjLabels[w, l])
    (mapping[v] != w);

solve ::int_search(sort_by(mapping, [ -p | p in patternDegree ]), first_fail, indomain, complete) satisfy;

