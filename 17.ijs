0 : 0
missed: dy < 0, y < min target y

try to restrict our search space
min y vel: 0 <. min target y
max x vel: 0 >. max target x
min x vel: 0 <. min target x
(trying to account for negative target x)

max y vel is trickier
possibly unbounded for some target settings

we return to y=0 after 2y+1 steps
with negative velocity one greater than we started

if 0 is not within goal y, then y > max abs goal y will skip through


can we assume range will always be unbounded if 0 avail?
so they won't give us such a problem
if some x triangular number is valid, this works
otherwise x actually constrains y - limited number of steps or you'll overshoot y
(unless you can hit it on the way up...)

meh I will peek at ys
all negative


after x steps we fall straight down, no more x vel
could prune at that point maybe

represent single state with
x dx
y dy
or maybe its transpose
)


read1 =: {{ ',' {. @: splitstring every }. '=' splitstring y }}

readrange =: 0". every '..' splitstring ]

read =: readrange every @: read1

in =: /:~"1 read 1!:1 <'/tmp/test'

xr =: {. in
yr =: {: in

NB. add velocity to position
step1 =: + 1 |.!.0"1 ]

dv =: {{ 0 ,. (-* (<0 1) { y),: _1 }}

step =: step1 + dv

NB. awkward to express with this structure
missed =: (0 > (<1 1)&{) *. ({.yr) > (<1 0)&{

stepterm =: 3 : 0
_2 Z: missed y
_2 Z: ({: xr) < (<0 0) { y
NB. stop if x past goal
NB. this would be too early if we could pass through while still going up
NB. but we see it's downward

NB. _2 Z: (0 = (<0 1) { y) *. (
NB. trying early term if stopped x and outside
step y
)

sim =: ] F: stepterm @: (0 & ,.)

g1 =: ({."1 in) & <: *. ({:"1 in) & >:
goal =:  [: *./ [: g1 {."1

heights =: (<1 0) & {"2
score =: >./ @: (heights * goal"2)

test =: (score @: sim)"1
NB. set score 0 if no goal. probably should be -∞ but assuming there is some positive winner

NB. assuming both positive for now
miny =: 0
minx =: 0
maxx =: {: xr
maxy =: >./ | yr

xs =: i. maxx
ys =: i. maxy
opts =: ,/ xs ,"0/ ys

out =: >./ test opts

NB. shoot below goal
miny =: {. yr
NB. total x dist = x*(x+1)/2
NB. never reach if below:
minx =: <. %: +: {. xr
NB. ok, doesn't trim that much

r =: [ + [: i. 1 + -~

xs2 =: minx r maxx
ys2 =: miny r maxy

opts2 =: ,/ xs2 ,"0/ ys2

test2 =: {{ +./ goal"2 sim y }}"1
out2 =: +/ test2 opts2
