/ Create playing card deck

td:"234567890JQKA" cross "HCDS"
tdsym:`$td
tdmap:asc tdsym
/	tdtbl:flip te:`id`card!flip tdmap
tn:til 52

/ Number of Players
n:5

/ Create game id
g:1
game:n#g	

/ Create list of player symbols with pattern `pn for all n
players:()
m:n
while[m>0;players:(`$("p",string(m))),players;m:m-1]	

/ Deal to players
/	tdd:(td  except (card1:(-1*n)?td))	/ Deals n cards
/	tdd:(tdd except (card2:(-1*n)?tdd))	/ Deals n cards again for hold'em

/ td except tdd = 10	/ 1b
tnd:(tn except (card1:(-1*n)?tn))
tnd:(tnd except (card2:(-1*n)?tnd))

/ Deal the Flop
/	tdd:tdd except flop:-3?tdd
tnd:tnd except flop:-3?tnd

/ Deal the Turn
/	tdd:tdd except turn:1?tdd
tnd:tnd except turn:1?tnd

/ Deal the River
/	tdd:tdd except river:1?tdd
tnd:tnd except river:1?tnd

/ Create Game Table
gamen:([game:game]players:players;card1;card2;n#enlist flop;n#turn;n#river)
gamet:([game:game]players:players;card1t:tdmap card1;card2t:tdmap card2;n#enlist tdmap flop;n#tdmap turn;n#tdmap river)

/ 
Sample Output:




game| players card1 card2 flop           turn river
----| ---------------------------------------------
1   | p1      "KH"  "AC"  "5S" "3S" "KC" "6H" "KD" 
1   | p2      "5H"  "9S"  "5S" "3S" "KC" "6H" "KD" 
1   | p3      "2D"  "8H"  "5S" "3S" "KC" "6H" "KD" 
1   | p4      "JH"  "0S"  "5S" "3S" "KC" "6H" "KD" 
1   | p5      "JC"  "QD"  "5S" "3S" "KC" "6H" "KD"
\

