input =: 0".&> ',' splitstring 1!:1 <'/tmp/test'



NB. total fuel used for position y
fuel =: {{ +/ | input - y }}


NB. assume positions >= 0, consider 0..maxpos-1
best =: <./ fuel"0 i. >./input

NB. n*(n-1)/2, floor to keep integer
cost =: {{<. -: (* >:) | y}}

fuel2 =: {{+/ cost input - y }}"0


best2 =: <./ fuel2 i. >./input


NB. without knowing n*(n-1)/2
cost3 =: {{ +/ i. >: | y }}"0

fuel3 =: {{+/ cost3 input - y}}"0

best3 =: <./ fuel3 i. >./input


NB. row of distances for each possible shift
distm =: -"1 0 [: i. >./

best1 =: {{ <./ +/"1 | distm y }}

NB. bitwise shift for lols
half=: _1&(33 b.)
cost =: {{ half (* >:) | y }}

best2 =: {{ <./ +/"1 cost distm y }}
