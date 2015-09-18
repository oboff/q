verb:``create`replace`update`delete`query`flip
noun:``atom`list`dictionary`table`function
prep:``with`without`from
adj:``monadic`dyadic`niladic`unary`binary

qkata:{(cross/) (adj;noun;prep;adj;noun)}
\

.stat.pctile:	{[p;x]x iasc[x] -1+ceiling p*count x}
		[p;x]		/n floats with values <1;uniform list
		count x		/monadic function takes list;int
		p*		/mutliply count by list;n float
		ceiling		/round up to nearest whole number;n float
		-1+		/subtract one;n float
		iasc[x]		/list of indexes for corresponding sorted list;list
		x		/index into list;list
				/;elements from sorted list eg. (x1..xn) p1..pn

.stat.u12:	{-6f+sum x cut (12*x)?1f}
		(12*x)?1f	/generate 12*x random floats with range of 0 to 1;floats
		x cut		/reshape the 12*x floats into x rows and 12 columns;lists(floats)
		sum		/sum the x rows;floats
		-6f+		/subtract 6 from each scalar;floats

.stat.bm:	{
		 if[count[x] mod 2;'length];	/if count of input is not divisible by 2, return exception
		 x:2 0N#x;			/reshape input into 2 even rows;lists
		 r:sqrt -2f*log x 0;		
		 theta:2f*acos[-1]*x 1;		
		 x: r*cos theta;		
		 x,:r*sin theta;		
		 x}				

cnorminv:	{
		 a:-25.44106049637 41.39119773534 -18.61500062529 2.50662823884;
		 b: 3.13082909833 -21.06224101826 23.08336743743
		   -8.47351093090 1;
		 x*:horner[a;s]%horner[b] s:x*x-:.5;
		 x}
			a and b		/polynomial coefficients
			x-:.5		/compound assignment, subtract 0.5;float
			s:x*x		/square;float
			horner[b] s	/call horner function;float
			horner[a;s]%	/divide result;float
			x*:		/multiply original input by new term and assign to x;float
			x		/return x;float

.stat.horner:	{{z+y*x}[y]/[x]}
		ex.
		a:1 2 3 4 5f
		s:2f
		horner[a] s
		{{z+y*x}[y]/[x]}[a] s
		{{z+y*x}[s]/[a]}
		{y+x*s}/[1 2 3 4 5f]
		{y+x*s}/{y+x*s}[1 2][3 4 5f]
		{y+x*s}/{2+1*s}[3 4 5f]
		{y+x*s}/[4 3 4 5f]
		{y+x*s}/[3+4*s][4 5f]
		{y+x*s}/[11 4 5f]
		{y+x*s}/[4+11*s][5f]
		{y+x*s}/[26 5f]
		57f
		
		/horner can also be used as:
		2f sv a

ewma:	{{(y*1-x)+z*x}[x]\[y]}
	x	\scalar
	y	\list
	ex.	
	x:0.25
	y:1 2 3 4 5f
	{{(y*1-x)+z*x}[x]\[y]}[.25][1 2 3 4 5f]
	{(y*1-x)+z*x}[.25]\[1 2 3 4 5f]
	{(x*.75)+y*.25}\[1 2 3 4 5f]
	{(x*.75)+y*.25}\(x*.75)+y*.25[1 2][3 4 5f]
	{(x*.75)+y*.25}\(1*.75)+2*.25[3 4 5f]
	{(x*.75)+y*.25}\[1.25 3 4 5f]
	{(x*.75)+y*.25}\(x*.75)+y*.25[1.25 3][4 5f]
	..	
ewma:	y(1-x)+zx
	y-yx+zx
	x(z-y)+y	/ = y+x*z-y
ewma:	{{z+y*x}\[first y;1-x;x*y]}	
	{{z+y*x}\[first y;1-x;x*y]}	
ewma:	{first[y](1f-x)\x*y}
ewma:	ex.
	0 (.9)\ .1*til 5	/ = .stat.ewma[.1;til 5]
				/ = {z+y*x}\[0;.9;.1*til 5]


?[;;]:	ex.
	?[10101010b;"z";"abcdefgh"]	/ ;"zbzdzfzh"
	?[10#01b;til 10;10#0]		/ ; 0 1 0 3 0 5 0 7 0 9

.stat.norminv:	{
		 i:x<.5;				/0 | 1b
		 x:?[i;1f-x;x];				/if i true, execute next expression, else last expression
		 x:?[x<.92;cnorminv x;tnorminv x];	/control flow
		 x:?[i;neg x;x];			/flip sign
		 x}					/

q)f:`:/tmp/stat.q
q)if[not ()~key f;system "l ", 1_string f]	/check file exists
q)if[f~key f;system "l ", 1_string f]

.stat.ac:	{x%first x:x{(y#x)$neg[y]#x}/:c-til c:count x-:avg x}
		x-:avg x	/subtract avg of every element of list;list
		c:count x	/;scalar
		c-til c		/reverse of list with index starting at 1;list
		/:		/each-right
		neg[y]#x	/take last y elements from list x;list
		(y#x)$		/take first y elements of x and dot product;list
		x{}		/first argument
		x%first x	/divide list by scalar;list

.util.use:	{system["d"] upsert $[99h=type v:get x;v;(-1#` vs x)!1#v]}
		system["d"]	/change directory
		upsert		/appends data in place
		$[		/begin conditional evaluation
		v:get x		/from symbolic directory name return dictionary
		99h=type v	/check for dictionary type
		(-1#` vs x)!1#v	/idk		

.stat.gbm	{[s;r;t;z]exp(t*r-.5*s*s)+z*s*sqrt t}
		/simple arithmetic

wday:		{x where 1<x mod 7}
		eg.
		q)(2000.01.01+til 14) mod 7
		0 1 2 3 4 5 6 0 1 2 3 4 5 6i
		q)1<(2000.01.01+til 14) mod 7
		00111110011111b
		q)2000.01.01+til 14 1<(2000.01.01+til 14) mod 7
		'length
		q)(2000.01.01+til 14) 1<(2000.01.01+til 14) mod 7
		2000.01.01 2000.01.01 2000.01.02 2000.01.02 2000.01.02 2000.01.02 2000.01.02 ..

		
