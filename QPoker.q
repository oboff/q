/ Create playing card deck
td:"234567890JQKA" cross "HCDS"

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
tdd:(td  except (card1:(-1*n)?td))	/ Deals n cards
tdd:(tdd except (card2:(-1*n)?tdd))	/ Deals n cards again for hold'em

/ td except tdd = 10 > 1b

/ Deal the Flop
tdd:tdd except flop:-3?tdd

/ Deal the Turn
tdd:tdd except turn:1?tdd

/ Deal the River
tdd:tdd except river:1?tdd

/ Create Game Table
gamet:([game:game]players:players;card1;card2;n#enlist flop;n#turn;n#river)
