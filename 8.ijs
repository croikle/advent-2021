lines =: cutopen 1!:1 <'/tmp/test'

inp =:  > cutopen each each '|' splitstring each lines

uniqs =: 2 4 3 7

outlens =: (# every) every {:"1 inp

out =: +/^:_ outlens e. uniqs


digits =: cutopen 'abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg'

mat =: 'abcdefg'&e. every digits


NB. probably some more general alg but...
NB. for 6 segments, 6 is the only one that doesn't include both of 1's segments
NB. 9 is the only one that includes all of 4's
NB. so 0 is the other

NB. sim for 5s, 3 is the superset of 1
NB. 2 intersects 4 at 2 places, 5 intersects 4 at 3
NB. or using 069, 5 is subset of 6


bits =: 'abcdefg'&e.every

NB. y rows are bits set for each observed digit
NB. output something, permutation or ?
NB. or just sorted rows in numeric order
solve =: 3 : 0
find =. {{ I. y = +/"1 x }}
one =. y find 2
four =. y find 4
seven =. y find 3
eight =. y find 7

sixes =. 6 = +/"1 y
NB. pick sixes, & one, find row with only one
six =. I. 1 = +/"1 (,one{y)*."1 sixes * y

nine =. I. 4 = +/"1 (,four{y)*."1 sixes * y

zero =. six -.~ nine -.~ I.sixes

fives =. 5 = +/"1 y
three =. I. 2 = +/"1 (,one{y)*."1 fives * y

two =. I. 2 = +/"1 (,four{y)*."1 fives * y
five =. two -.~ three -.~ I.fives

zero, one, two, three, four, five, six, seven, eight, nine
)

row =: 3 : 0
sol =. ({~ solve) bits > {. y
disp =. bits > {: y
sol i. disp
)

out =: +/ 10 #."1 row"1 inp

NB. shuffle columns, match expected digit forms
NB. inefficient but more general

ana =: {{x A.&.|: y}}"0 _

NB. has all rows that we expect
ok =: 0 = [: # mat -. ]

NB. index of the permutation that fits
idx =: {{ 1 i.~ (i.!7) (ok @ ana) y }}


row =: 3 : 0
'a b' =. bits each y
i =. idx a
unscrambled =. i A.&.|: b
10 #. mat i. unscrambled
)

NB. runs at higher rank, faster
NB. still 6-10ms per solve
idx2 =: {{ 0 i.~ ((i.!7) A.&.(|:"2) y) #@:-."2 mat }}


NB. for more efficiency, maybe build intersection counts between each digit
NB. 

auto =: +/ . * |:

key =: /:~"1 auto mat

NB. note that each digit looks unique even when ordered
NB. we are throwing away some information but it works

as =: > {."1 bits each inp
bs =: > {:"1 bits each inp

sols =: key i. /:"1~ auto"2~ as

codes =: as i."2 bs

decoded =: 10 #. codes {"1 sols
