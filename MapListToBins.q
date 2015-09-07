ltbins:{[bs;l]
 n:1+max l;
 map:til[n]!tbins:n#raze bs#'til (1+floor n%`float$bs);
 l!map[l]
 }
