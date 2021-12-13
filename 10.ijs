NB. One idea: recursively remove empty pairs
lines =: cutopen 1!:1 <'/tmp/test'

es =: 4 2 $ '()[]<>{}'


emask =: {{ (+ _1&|.) +/ es E."1 y }}

NB. step =: ] #~ [: -. emask
NB. y #~ -. emask y
step =: {{ y #~ -. emask y }}

sweep =: step^:_

next =: {{ y -. '([{<' }}

terms =: ')]}>'

scores =: 3 57 1197 25137 0

scorechar =: { & scores @ (terms & i.)

score =: {{ scorechar {. next sweep y }}

out =: +/ > score each lines


bad =: {{ 0 < # next sweep y }}

bads =: > bad each lines

rest =: (-. bads) # lines

score2 =: ' ([{<'

sc =: {{ 5 #. |. score2 i. sweep y }}
scores2 =: sc every rest

med =: {{ (<. -: # y) { /:~ y }}

out2 =: med scores2
