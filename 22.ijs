in1 =: cutopen every cutopen 1!:1 <'/tmp/test'

onoff =: (,:<'off') i. {."1 in1

isnum =: e.&'-1234567890'

exnum =: {{ 0 ". (isnum y) } ' ' ,: y }}

NB. extract numbers, form into 2x3 blocks
NB. x1 y1 z1
NB. x2 y2 z2
exnum =: {{ |: 3 2 $ 0 ". (isnum y) } ' ' ,: y }}

pts1 =: exnum every {:"1 in1

NB. 1 for points within init area
init =: (*./@:,"2) 50 >: | pts1

NB. select those, shift by 50 so indices >:0
pts2 =: 50 + init # pts1
on2 =: init # onoff

NB. -50 .. 50
n1 =: 101

NB. n1 entries, 1 between x and y
f =: {{ (x&<: *. y&>:) i.n1 }}"0

NB. make cube of 1s in field of 0s
NB. specified by points in format above
mkc =: (*.// @: f)/"2

zero =: (n1,n1,n1) $ 0

NB. wrap on/off commands with masks
steps =: on2 ;"_1 mkc pts2

NB. choose which operation based on command
step =: 4 : 0
'on mask' =. x
g =. ([ *. -.@:])`+.
y g@.on mask
)

NB. fold, returning number lit at end
out1 =: zero (+/@:,)F..step steps


NB. volume of a cube
vol =: {{ */ >: | -/ y }}"2


NB. intersection of two cubes
NB. assumes form from above with 1s < 2s
NB. highest low point .. lowest high point, on x,y,z
int =:({. @: >.) ,: ({: @: <.)
NB. alternate, picks rows before comparing
int2 =: ( (>. &: {.) ,: (<. &: {:) )"2

NB. int returns negative-side cubes if no intersection
NB. this detects and rejects them
real =: {{ */ 0 <: -~/ y }}"2

NB. filter unreal from list of cubes
freal =: real # ]

NB. variables to accumulate cubes
pos =: 0 2 3 $ 0
neg =: 0 2 3 $ 0

NB. track cube volume using intersections
NB. we store both overlapping cubes, and a negative 
NB. of their intersection
NB. once multiple cubes are around, subtract intersections with each
NB. but re-add intersections with negatives since they got subtracted twice
add =: 4 : 0
'on cube' =. x
'pos neg' =. y
newneg =. freal cube int2 pos
newpos =. freal cube int2 neg
NB. include this cube only if turning on
NB. all other steps are the same!
NB. since we can think of on as turning off any intersecting points, then adding our whole cube
pos =. pos , (cube&,)^:on newpos
neg =. neg , newneg
NB. progress meter. I was concerned cube count would go exponential; luckily there wasn't persistent overlap in the rest of the data set
echo # pos
pos ; neg
)

steps2 =: onoff ;"_1 pts1


netv =: -/ @: ((+/ @: vol) every)

out2 =: (pos;neg) netv F.. add steps2
