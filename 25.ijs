init =: > cutopen 1!:1 <'/tmp/test'
init2 =: <: 'v.>' i. init
NB. south is -1, empty is 0, east is 1

open =: -. @: |

e =: 1&=
s =: _1&=

emoves =: e *. (1&|."1 @: open)

emove =: + (-~ _1&|."1) @: emoves

smove =: emove &. (|: @: -)
step =: smove @: emove
settle =: step^:_

NB. awkward to actually get the iteration count...

i =: 0
step2 =: 3 : 0
i =: i + 1
step y
)

step2^:_ init2
echo i
