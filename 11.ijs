lines =: cutopen 1!:1 <'/tmp/test'
grid =: 0"."0 every lines


smear =: [: +/ _1 0 1 & (|.!.0"0 _)

smear2 =: smear &. |: @ smear

NB. represent spent octopus by negative inf
smearminus =: smear2 - _&*

f =: 9 & <
step =: + (smearminus @ f)

NB. repeat step until converged
NB. multiply __ cells by 0 to reset
settle =: (* __&~:) @ (step^:_)

next =: settle @: >:

states =: next^:(<101) grid

out =: +/ , 0 = states

goal =: 0"0 grid

go =: {{ -. goal -: 0 {:: y }}

inc =: 3 : 0
'l r' =: y
(next l) ; >: r
)

out2 =: 1 {:: inc^:go^:_ grid ; 0
