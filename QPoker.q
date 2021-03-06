/ Create playing card deck
numc:2+til 14
facec:`c`d`h`s
d:numc cross facec

/ Number of Players
n:5

/ Create game id
g:1

/ Create list of player symbols with pattern `pn for all n
players:()
m:n
while[m>0;players:(`$("p",string(m))),players;m:m-1]	

/ Deal to players
tn:til 52
dd:tn except card1:(-1*n)?tn
dd:dd except card2:(-1*n)?dd
dd:dd except flop:-3?dd
dd:dd except turn:1?dd
dd:dd except river:1?dd

/ Create Game Table
/gamen:([game:game]players:players;card1;card2;n#enlist flop;n#turn;n#river)
/gamet:([game:game]players:players;card1t:tdmap card1;card2t:tdmap card2;n#enlist tdmap flop;n#tdmap turn;n#tdmap river)

gamen:players!cardsn:(((card1,'card2,'n#enlist flop),'n#enlist turn),'n#enlist river)
gamef:players!d[cardsn]

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
