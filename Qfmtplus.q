/y:decimal places;x:list of numbers;returns list of formatted numbers

Qfmtplus:{[y;x]x:.Q.fmt[1+y+count string floor x;y]x;"F"$x} '
