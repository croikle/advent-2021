lines =: cutopen 1!:1 <'/tmp/test'
grid =: 0"."0 every lines

NB. make array matching grid with 0 in corner and ∞ elsewhere
NB. entries are minimum distance known from start point
start =: 0 (<0 0) } ($ grid) $ _

NB. shift down, fill with ∞
dn =: |.!._

NB. for each point, see if we can get a shorter dist based on the dist of the point above
NB. tryd y -> min(y, grid + dn(y))
NB. `grid` is used to add the cost of the current cell to the cost known for the neighbor
NB. this applies to and updates a full grid of known distances
tryd =: <. grid + dn

NB. adverb to make a similar test for a given shift
NB. so we can repeat ourselves less
t =: {{ <. grid + u }}

NB. using t with 4 different shifts for 4 directions
NB. shift down, up, right, left.
NB. shifting right is just shifting down along the other axis
tryd =: dn t
tryu =: 1 & dn t
tryr =: dn"1 t
tryl =: 1 & dn"1 t

NB. try each direction in turn
step =: {{ tryd tryu tryr tryl y }}

NB. repeat until converged
NB. (step to the power infinity)
map =: step^:_ start

NB. last element of last row: bottom right corner
out =: {: {: map


NB. Part 2

NB. mod 9 under decrement. 
NB. 1 + (y-1 mod 9)
wrap =: 9&| &. <:

NB. addition table
NB. 0 1 2 3 4
NB. 1 2 3 4 5
NB. 2 3 4 5 6
NB. 3 4 5 6 7
NB. 4 5 6 7 8
world =: +/~ i.5

NB. make copies of grid for each cell in world, adding the value inside
NB. then stitch them together and wrap values > 9
grid2 =: wrap ,./,./ grid +"_ 0 world

start2 =: 0 (<0 0) } ($ grid2) $ _

t2 =: {{ <. grid2 + u }}
d2 =: dn t2
u2 =: 1 & dn t2
r2 =: dn"1 t2
l2 =: 1 & dn"1 t2
step2 =: {{d2 u2 r2 l2 y}}

NB. alternate version, more DRY. u t3 y = test shift down under transform u
NB. (transform, shift, untransform)
NB. where transforms we use are identity, reverse, transpose, reverse transpose
NB. this transforming back and forth seems to profile a little slower
t3 =: {{ <. grid2 + dn&.u }}
d3 =: ] t3
u3 =: |. t3
r3 =: |: t3
l3 =: |. @: |: t3
step3 =: {{d3 u3 r3 l3 y}}

m2 =: step2^:_ start2
NB. takes about 4.5 seconds for me, not great but workable
out2 =: {: {: m2
