in =: cutopen 1!:1 <'/tmp/test'

bin =: '.#' & i.

prog =: bin > {. in

board =: bin every }. in

NB. add x around the edge
exp =: {{ x , (x ,. y ,. x) , x }}

enh =: {{ prog {~ #. , y }}

enhance =: {{ (1 1 ,: 3 3) enh;._3 x&exp x&exp y }}

NB. at least with my input 0 -> 1 alternates infinitely

out =: +/ , 1&enhance 0&enhance board


enh2 =: (1&enhance) @: (0&enhance)

out2 =: +/ , enh2^:25 board
