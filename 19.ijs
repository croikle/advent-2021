scans =: (LF,LF) splitstring commaspace 1!:1 <'/tmp/test'
commaspace =: {{ (' ',a.) {~ (',',a.) i. y }}

p =: {{ 0 (". commaspace) every y }}

pscan =: {{ p }. cutopen y }}

in =: pscan each scans

NB. all axis permutations, all signs is 48
NB. this includes half that are inverted righthand
NB. is there an easier way to specify the right ones?
NB. might be able to generate with a couple rotations
NB. or just use all 48 to be lazy

plusminus =: _1^#:i.8

shuffle =: {{ (i.6) (A. &. |:)"0 _ y }}

flips =: {{ ,/ plusminus (*"1 1)/ y }}

rolls =: ,/@:(i.@:(_2{$) (|."0 2)/ ])

NB. subtract first row
recenter =: ] -"1 {.

intersect =: [ -. -.

variants =: {{ recenter"2 rolls flips shuffle y }}

matches =: {{ 12 <: >./ (recenter x) (#@:intersect)"2 variants y }}

idx =: {{ 1 i.~ 12 <: (recenter x) (#@:intersect)"2 variants y }}

merge =: idx { variants@:]
NB. this assumes the first point in x is one of the matches
NB. could rotate them as well
NB. run over a convex hull if you want to minimize, but dunno how

NB. to account for cases where first of x is not match
NB. for each pair from x and y, the offset to add to y to line them up
offsets =: {{ ,/ x -"1/ y }}"2

v2 =: flips @: shuffle

NB. do the addition, produce variant of y for each offset
offset =: {{ (x offsets y) +"1/ y }}"2

markedoff =: 4 : 0 " 2
os =. x offsets y
os ;"_1 os (+"1/)"2 y
)

candidates =: {{ ,/ x offset v2 y }}

mcand =: {{ ,/ x markedoff v2 y }}


overlap =: {{ 12 <: x (#@:intersect)"2 y }}
anyover =: +./ @: overlap
overidx =: 1&(i.~) @: overlap

merge =: 4 : 0
c =: x candidates y
id =: x overidx c

~. x , id { c
)

merge2 =: 4 : 0
c =. x mcand y
os =. > {."1 c
pts =. > {:"1 c
id =. x overidx pts
echo id { os
scanpos =: scanpos , id { os
~. x , id { pts
)


process =: 4 : 0
if. # y do.
h =. {. y
rest =. }. y
try.
new =. x merge2 > h
new process rest
catch.
x process rest,h
end.
else.
x
end.
)

scanpos =: ,: 0 0 0
pts =: (> {. in) process }. in
out =: # pts
NB. oof, took a minute and a half


mnh =: +/ @: | @: -

maxman =: >./ @: , @: (mnh"1/~)
