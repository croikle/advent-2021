NB. Thinking of representing this with flat list instead of nested pairs
NB. __ and _ for brackets
NB. This makes it easier to find next/prev entries.

lines =: cutopen 1!:1 <'/tmp/test'

stripcommas =: #~ ','&~:

parse =: ((__ * ']'&=) + (_ * '['&=) + 0&"."0)"1

inp =: parse @: stripcommas each lines


nest =: {{ +/\-/_ __ =/ y }}
num =: __&< *. _&>

explodelocs =: 1 1 E. 5 <: num * nest

doexplode =: +./ @: explodelocs

explodeloc =: 1 i.~ explodelocs

splitloc =: 1 i.~ num *. 9&<
dosplit =: splitloc < #



explode =: 4 : 0
'a b' =. (x ,: 2) ];.0 y
left =. (0 ,: <: x) ];.0 y
right =. ((x + 3) ,: _) ];.0 y
makeL =. + (a * i.@:# = findL1)
makeR =. + (b * i.@:# = findR1)

(makeL left) , 0 , makeR right
)

findL1 =: 1 i:~ [: num ]
findR1 =: 1 i.~ [: num ]

split =: 4 : 0
n =. x { y
l =. (0 ,: x) ];.0 y
r =. ((>:x) ,: _) ];.0 y
l , _ , ((<. , >.) -: n) , __ , r
)

ex =: (explode~ explodeloc) ^: doexplode
sp =: (split~ splitloc) ^: dosplit

reduce =: (sp @: (ex^:_))^:_

mkpair =: (_&,) @: (,&__) @: ,
add =: reduce @: mkpair
sum =: (add &. >) foldl

NB. normal / is right-assoc, we need left
foldl =: {{ u~/ @: |. }}


NB. not very efficient; do the same list splicing a step at a time to find magnitudes
mloc =: 1 i.~ 1 1 E. num

mag =: 4 : 0
pair =. (x ,: 2) ];.0 y
left =. (0 ,: <: x) ];.0 y
right =. ((x + 3) ,: _) ];.0 y
left , (+/ 3 2 * pair) , right
)

m1 =: (mag~ mloc)^:(1<#)
m =: m1^:_

out =: m > sum inp

table =: (m @: add & >)/~

out2 =: >./ , table inp
