file=: cutopen 1!:1 <'/tmp/test'


moves =: (;/(s:'forward';'up';'down')) ,: 1 0; 0 _1 ;0 1

commands =: s:'forward';'up';'down'
actions =: 1 0 , 0 _1 ,: 0 1

act =: actions {~ commands i. s:

splitline =: [: cutopen >
parse =: 3 : '(act {. y) * 0". > {: y'

moves =: (parse @: splitline)"0 file

sol1 =: */+/ moves


fws =: {. |: moves
ups =: {: |: moves

aims =: +/\ ups

h =: +/ fws
v =: +/ fws * aims
out =: h*v

