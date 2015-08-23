\
q-learning notes

Q Tips: Fast, Scalable and Maintainable Kdb+

Source code extension: .q
Comments in source code: 
  for multiline, a single forwardslash (/) until a single backslash (\). Alternatively, a single \, not preceeded by a /, causes interpreter to ignore everything following. for single line, use /.

\\ : exit
\ : toggle k) or q) or fallback to q) when in debug mode,
\d : change directory, ex. \d <library.q>, \d <namespace>, \d .  ->  q)
key` : available namespaces

File Paths
  q)path:"/tmp"
  q)system "l ",path,"/stat.q"
  q)"/" sv (path;"stat.q")  ->  "/tmp/stat.q"

File Handles
  0: STDIN
  1: STDOUT
  2: STDERR

  ex.
  q)1 "hello world\n"
  hello world
  1
  q)1 "hello world\n";  ->  hello world    /semi-colon returns null 
  q)-1 "hello world";  -> hello world    /negative auto appends newline
    
ex.
  genp:{[id;S;s;r;dtm] 
   t:abs type dtm;
   tm:("np" t in 12 14 15h)$dtm;
   p:S*path[s;r;tm%365D06];
   c:`id,`time`date[t=14h],`price;
   p:flip c!(id;dtm;p);
   p}
  /functions require leading whitespace and semicolon for each line after the first. last line is return statement.
: OR set: assignment, ex. `a set 1 2 3  
+: : compound assignment, ex. x-:avg x = x:x-avg x -> 1b
= : tests equality, member by member is left operand is a list, ex. q)(1,2,3) = 3  ->  001b
~ : tests exact match, ex. q)(1,2,3) ~ 3  ->  0b, ex. q){x+y}[1;2]~{y+x}[2;1]  ->  1b
enlist : creates list of single element, ex. enlist 3  ->  ,3
[] : encloses parameters to a function call. indexes into list.
(;) : creates same or mixed list
(,): creates same list.
$ : cast operator, ex. "f"$10f -> 10i
% : division operator
mod : modulo
& : AND (MIN)
| : OR (MAX)
# : take elements from list, ex. 5#"hello world" -> "hello" (negative number would start from end); reshape list, 
  ex.
    q)4 4#til 10
    0 1 2 3
    4 5 6 7
    8 9 0 1
    2 3 4 5
; if the left operand is a list of two numbers, the output takes
NxM shape.
_ : drop lists at specified numbers, 
  ex. 
    q)3 5 8 _ til 10
      3 4
      5 6 7
      8 9
0N : null data type, must include type, ex. 0N is null integer
factorial: prd 1 + til 10
? : generate, ex. 5?5 3 2 1 2 5 (negative left operand "deals", without replacement), ex. 10?0Nc _> "dyqoskxdqc"
?[;;] : vector conditional, ex. ?[1<5; "yes"; "no"],
  ex. 
    q)?[10101010b;"z";"abcdefgh"]
    "zbzdzfzh"
sv OR vs : scalar from vector OR vector from scalar
cross : cross-product ex. show fd:"234567890JQKA" cross "DCHS"
show : output result
\S : random seed
cut : cuts the row to specified size, 
  ex. 
  q)4 cut 12?10
  2 4 5 4
  2 7 8 5
  6 4 1 3
flip : transpose rows and columns
/ : over, ex. horner:{{z+y*x}[y]/[x]} -> a[3]+s*a[2]+s*a[1]+s*a[0] OR system command to load namespace, ex. \ .stat -> q.stat) 
\ : scan, outputs iteration results, ex.
  q)0 (.9)\ til 5   /same as {z+y*x}\[0;.9;.1*til 5] OR {first[y](1f-x)\x*y} A.K.A. ewma (exponential weighted moving average)
  0 1 2.9 5.61 9.049
value : shows the values of namespace variables
\P : precision/number of significant digits, to view all digits set to 0, ex. \P 0
prds : uniform function for prd
! : creates a dictionary from two lists (key, value), ex. dt!p  ->  2001.01.01 | 100
-16! : reference count of given variable
0N! : shows underlying data structure of object

Dictionaries
  list functions apply the same
  index into dictionary passing key as parameter in brackets
  # used to retrieve one or more elements of dictionary with key as parameters
  update values using assingnment, ex: q)d[2000.01.02]:99f, ex. show d,:2000.01.01 2000.01.02!101 102f
  with multiple keys, index into dictionary with `<column name>; <row number> or flip dictionary and index into <row number>,<column name>

Tables
  Table is a flipped dictionary of lists. 
  Can also be constructed using ex. ([]id:0;date:dt;price:p) OR ([]id;dt;p) OR ([id:0;date:dt]price:p)
    [] defines primary key
  To retrieve keys or values, unflip table, ex. q)key flip t  ->  `id`date`price
  To retrieve columns, use cols
  Take subset with <column name>#<table name>
  Index by column <table name> <column name>
  /: : each-right operator, used with # to take first, few, or last columns of table, 
    ex. 
      q)2#/:t
      id date
      -------------
      0  2000.01.01
      0  2000.01.02
  xkey : reorder and key columns, ex. `id xkey t  ->  id| date       price
  ! : key the table, ex. 2!t  ->  id date      | price
  Query multiple keys with a table, ex. t ([]id:0;date:2000.01.01 + til 5)
  \a OR tables: shows tables of namespace 
  meta : provides schematic for given table, type, foreign-key and attribute of each column
    ex. 
      q)meta t      
      c    | t f a  
      -----| -----  
      id   | j      
      date | d      
      price| f      
  Q has four different tags (or attributes): sorted (`s, ascending order), unique (`u, dictionary or single column key), parted (`p, multiple keys, faster than sorted; same as clustered index in sql) and grouped (`g, unsorted keys). See Q Tip 8.5.



