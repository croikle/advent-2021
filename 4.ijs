file=: cutopen 1!:1 <'/tmp/test'
moves =: 0". > ',' splitstring > {. file

boards =: 0". > > _5<\}.file


boards2 =: >_5<\ 0". > }.file

boards3 =: _5[\ 0". > }.file

colmasks =:  5 5$"1 =/~ i.5
rowmasks =: |:"2 colmasks
masks =: colmasks,rowmasks


NB. true if binary board has a win
win =: {{ 5 e. +/"1+/"1 masks (*"2) y }}


winners =: {{ win"2 boards e. y}}

winround =: 1 i.~ +/"1 winners\ moves

winner =: 1 i.~ winround { winners\ moves

winmask =: (winner { boards) e. (winround + 1) {. moves

boardpoints =: +/^:_ (-. winmask) * winner{boards

out =: boardpoints * winround{moves

games =: boards&e.\ moves

NB. 4 dimensions
NB. Outer rank - move sequence
NB. Next - board number

wins =: win"2 games

NB. 100 x 100, moves vs boards
NB. beautiful

allwon =: <./"1 wins
round =: allwon i. 1

loser =: ((round - 1) { wins) i. 0
remaining =: (-. loser { round { games) * loser { boards

(round { moves) * +/^:_ remaining


