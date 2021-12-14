in =: 1!:1 <'/tmp/test'

'str1 str2' =: (LF,LF) splitstring in

rules =: ' -> ' splitstring"1 > cutopen str2

matches =: {{ (0{::"1 rules) E."1 y }}

outs =: ,1{::"1 rules

inserts =: {{ (|: matches y) <@# outs }}

step =: {{ ;(<"0 y) ,. inserts y }}

counts =: #/.~ step^:10 str1

diff =: >./ - <./
out =: diff counts


NB. Represent as count of each digraph instead of full string

chars =: ~. str1 , ;rules

pairs =: ,"0/~ chars

startpairs =: 2[\str1

start =: +/ startpairs -:"1/ pairs

NB. flattening to 1d list to express computation more easily
pairs2 =: ,/pairs

start2 =: +/ startpairs -:"1/ pairs2

NB. rules will make 100*100 matrix, apply to vec to progress

NB. KF, O --> KO, OF
outpairs =: {{ (({. x) , y) ,: y , {: x }}

rule_outpairs =: outpairs&:>/"1 rules

numeric_rule_out =: pairs2 i. rule_outpairs
numeric_rule_in =: pairs2 i. 0{::"1 rules

rowout =: {{ y +/@:(=/) i. #pairs2 }}"1

id =: =/~i.#pairs2

NB. replace each rule's row in identity matrix with its output row
m =: (rowout numeric_rule_out) numeric_rule_in} id

NB. multiply by our matrix
next =: (+/ . *) & m

NB. count individual elements for each type of pair
paircounts =: (chars i. pairs2) +/@:(=/)"1 i. #chars
doublecounts =: (+/ . *) & paircounts
NB. each element counted twice, except for end points
ends =: chars i. ({. , {:) str1
endcounts =: +/ ends { =/~ i. # chars
adjusted =: <. -: endcounts + doublecounts next^:40 start2
out2 =: diff adjusted
