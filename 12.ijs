lines =: cutopen 1!:1 <'/tmp/test'
pairs =: '-' splitstring every lines

keys =: ~. , pairs

start =: keys i. <'start'
end =: keys i. <'end'

pairsnum =: keys i. pairs

upper =: a. {~ 65+i.26
anyup =: +./ @: (e.&upper)
keysup =: anyup every keys
small =: -. keysup

s =: #keys

NB. wonder if there's a better way
m1 =: 1 ( <"1 pairsnum)} ((s, s) $ 0)
m2 =: (+. |:) m1

mask =: {{ (+. |:) (s,s) $ y = i.s }} 

NB. only applies if lowercase
mcase =: {{ (-. y { keysup) * mask y }}

mnext =: * (-. @ mcase)

f =: 4 : 0 "_ 0
next =. I. y { x
if. # next do.
mat =. x mnext y
rest =. +/ mat f next
rest + y = end
else. y = end end.
)

out =: m2 f start


g =: 4 : 0 "_ 0
'y1 trace' =. >y
NB. echo x; y1; trace
newx =. x + y1 = i. s
usedtwice =. +./ 1 < newx * small
forbidden =. (start = i.s) +. usedtwice *. small *. newx > 0
options =. I. (y1 { m2) *. -. forbidden
if. y1 = end do.
NB. echo 'end';trace
1
elseif. # options do.
NB. echo 'options';options
+/ newx g <"1 options;"0 _ trace , y1
else. 0 end.
)

out2 =: (s $ 0) g <start ; $0


0 : 0
can make adjacency matrix
also bool array for whether state is repeatable
I guess maybe we can implement normal recursion?
remove state when leaving if lowercase
is there some more array-based method?
number of routes from a to b within c moves
might just be powers of adjacency matrix
but doesn't handle the repetition criterion

given matrix x and startpoint y, how many ways to end?
if y = end, 1
else...

y = end + (y ~: end) * ...
this would attempt to leave end state
but maybe ok since it will remove it

------
have to track visitation
pass state along instead of modified matrix
preventing start reentry may be slightly messy


)



