NB. could model as positions, index of die

ds =: (+/"1) 100 3 $ >: i.100
m10 =: (10&|)&.<:


NB. messy, split this
({{3 * >:1 i.~ 1000<:y}}*{{y {~ <: 1 i.~ 1000<:y}})  , +/\ }. m10@:+/\ 4 8 , 200 2 $ ds


NB. similar story to earlier days
NB. state: player positions and scores
NB. build table, one cell for each possible state
NB. count of universes with that state
NB. progress: take table to next
NB. maybe 2 extra final states with wins
NB. or just don't progress won states

NB. pos1 pos2 score1 score2
NB. 10 * 10 * 21  *  21
NB. positions 0-9 (add 1 to get game positions)
NB. scores 0-20

NB. scores over 27 universes for 3 rolls
roll =: , +// 3 3 $ 1 2 3
NB. or gather
r2 =: (~. ,: #/.~) roll
NB. 3 4 5 6 7 8 9
NB. 1 3 6 7 6 3 1

zero =: 10 10 21 21 $ 0

NB. manually put inputs in here, subtracting one
NB. One initial universe, positions and zero score
init =: 1 (<7 4 0 0) } zero

NB. process the dice roll and move, but not score 
NB. by rotating along p1 position axis each possible move
NB. and then summing
p1forward =: {{ +/ (-roll) |."0 _ y }}

NB. score p1 by their position
NB. rotate each slice (p1 position fixed)
NB. by its p1 position, along p1 score axis
score1 =: {{ (0 ,. (- >: i.10) ,. 0) |.!.0"1 3 y }}

NB. extend board by 10 in p1 score to capture wins
endzone =: (, & (10 21 $ 0))"2

NB. count universes in endzone
wins =: {{ +/ , (0 0 21 0 ,: _ _ _ _) ];.0 y }}

NB. chop off the endzone
rest =: (0 0 0 0 ,: _ _ 21 _) & (];.0)

NB. swap p1/p2 so we don't need to reimplement
swap =: 1 0 3 2 & |:

NB. thread 3 values: active player wins, table, inactive player wins
NB. return state ready to be processed for other player
NB. so we can simply iterate this
step =: 3 : 0
'a t i' =. y
t2 =. score1 endzone p1forward t
i ; (swap rest t2) ; a + wins t2
)

NB. initial state with zero wins
base =: 0 ; init ; 0

NB. have to go in steps of 2, or ^:_ won't stop
NB. since otherwise we toggle between p1 and p2
out =: >./ > 0 2 { (step^:2)^:_ base
