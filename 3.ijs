file=: cutopen 1!:1 <'/tmp/test'


col=: {{ (-: # y) < +/ '1' = y}}

ones =: col"1 |: > file

out =: (#. ones) * #. -. ones

bin =: '1' = > file

most =: # <: 2 * +/

step1 =: (= most) {. |: bin

NB. step1 # bin is now the filtered set
stepn =: {{ (= most) x { |: y}}

f =: #~ 0&stepn
g =: #~ 1&stepn



NB. step takes an index x and a table. applies process on x column, returns filtered table

stepx =: {{(= most) y { |:}}
step =: {{ y #~ (= most) x { |: y }}


val1 =: #. 10 step 9 step 8 step 7 step 6 step 5 step 4 step 3 step 2 step 1 step 0 step bin

NB. try to do this automatically

step2 =: {{ y #~ (-. = most) x { |: y }}


val2 =: #. 7 step2 6 step2 5 step2 4 step2 3 step2 2 step2 1 step2 0 step2 bin

NB. dyadic hook, x { |: y
sel =: { |:


selector =: [: (= most) sel

f =: 13 : 'y #~ x selector y'
f =: ] #~ selector

selector2 =: [: (= most) ({ |:)


