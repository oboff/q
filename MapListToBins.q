ltbins:{[bs;l]
 n:1+max l;
 map:til[n]!tbins:n#raze bs#'til (1+floor n%`float$bs);
 l!map[l]
 }

/
sample output:
q)ltbins[2;0 1 2 3 4 5 6 8 9]
0| 0
1| 0
2| 1
3| 1
4| 2
5| 2
6| 3
8| 4
9| 4
