NB. I don't know how to do this one in an "array language style"; it seems like a very sequential process

NB. represent packet as 3-tuple
NB. version, type, contents
NB. if type isn't 4, contents is a list of packets

NB. hex to bits
bits =: {{ , #: '0123456789ABCDEF' i. y }}

NB. split off first 3 bits as number, return with rest
get3 =: {{ (#. 3 {. y) ; 3 }. y }}

NB. arrange in rows of 5
fives =: _5 & (]\)

NB. parse a literal num, return value with rest
num =: 3 : 0
fives =. _5 ]\ y
ct =. >: 0 i.~ {."1 fives
val =. #.,(0 1 ,: ct, 4) ];.0 fives
rest =. y }.~ 5 * ct
val ; rest
)

NB. parse operator packet contents
op =: 3 : 0
if. {. y do.
op1 }. y
else.
op0 }. y
end.
)

NB. type 0, bit length.
op0 =: 3 : 0
len =. #. 15 {. y
dat =. (15,:len) ];.0 y
rest =. (15 + len) }. y
(($0) lenpack dat) ; rest
)

NB. read until input consumed
NB. x y = acc inp
lenpack =: 4 : 0
if. 0 = # y do.
x
else.
'res rest' =. pack y
(x,res) lenpack rest
end.
)

NB. type 1, number of packets
op1 =: 3 : 0
np =. #. 11 {. y
np npack ($0) ; y }.~ 11
)

NB. read n packets
npack =: 4 : 0
'acc inp' =. y
if. x = 0 do.
y
else.
'res rest' =. pack inp
(<: x) npack (acc,res);rest
end.
)

NB. read a packet
pack =: 3 : 0
'v r1' =. get3 y
't r2' =. get3 r1

if. t = 4 do.
'val rest' =. num r2
else.
'val rest' =. op r2
end.
(< v;t;<val) ; rest
)

NB. sum versions over packet tree
vsum =: 3 : 0
'v t body' =. y
if. t = 4 do.
in =. 0
else.
in =. +/ vsum every body
end.
v + in
)

parse =: {{ (0;0) {:: pack bits y }}

vs =: vsum @: parse

NB. operations indexed by type
NB. dummy in index 4 which is handled differently
ops =: +`*`<.`>.`]`>`<`=

eval =: 3 : 0
'v t body' =. y
if. t=4 do.
body
else.
subs =. eval every body
NB. select and apply operation based on type
ops@.t/ subs
end.
)

e =: eval @: parse
