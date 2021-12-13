input =: 0".&> ',' splitstring 1!:1 <'/tmp/test'

age =: [: 6:^:(<&0)"0 <:

spawn =: 8 #~ [: +/ 0 = ]

next =: age , spawn

out =: # next^:80 input

NB. new model: 9-vector, how many fish of each age

start =: +/"1 (i.9) ="0 1 input

NB. also some solution with /.
NB. might not include each value though

zto6 =: (6=i.9) * {.

NB. Rotation creates spawn at index 8, need to add parents at index 6
next =: zto6 + 1 |. ]

out2 =: +/ next^:256 start
