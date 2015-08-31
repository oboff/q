qpoker:{
	numc:2+til 14;
	facec:`c`d`h`s;
	d:numc cross facec;
	n:1;
	g:1;
	players:();
	m:n;
	while[m>0;players:(`$("p",string(m))),players;m:m-1];
	tn:til 52;
	tn:-52?tn;	
	dd:tn except card1:(-1*n)?tn;
	dd:dd except card2:(-1*n)?dd;
	dd:dd except flop:-3?dd;
	dd:dd except turn:1?dd;
	dd:dd except river:1?dd;
	gamen:players!cardsn:(((card1,'card2,'n#enlist flop),'n#enlist turn),'n#enlist river);
	gamef:players!d[cardsn];
	/ runs:(flip qpoker `);
	/ do[10;runs:runs,(flip qpoker `)];
	/ gid:11 xrank til 77;
	/ gamen2:id xcols update id:gid from runs;
	gamen}
