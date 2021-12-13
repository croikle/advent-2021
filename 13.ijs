in =: 1!:1 <'/tmp/test'

'ptstr fstr' =: (LF,LF) splitstring in

pts =: 0". every ',' splitstring every cutopen ptstr

f2 =: '=' splitstring every cutopen fstr

fnums =: 0". every {:"1 f2
faxes =: (<'fold along y') = {."1 f2

folds =: faxes ,. fnums
NB. first assume fold along y

xs =: {. |: pts
ys =: {: |: pts

f1 =: {. fnums
foldedys =: f1 - | f1 - ys

fpts =: ~. xs ,. foldedys

fold =: 4 : 0
'axis val' =. y
NB. probably an if is clearer
NB. foldx under (reverse if y axis)
NB. `a: part means we only apply to left arg
x foldx &.:((|."1^:axis)`a:) val 
)

foldx =: 4 : 0
xs =. {."1 x
ys =. {:"1 x
folded =. y - | y - xs
~. folded ,. ys
)

out1 =: # pts fold {. folds

done =: pts ] F.. (fold~) folds

size =: >./ done

msg =: |: '#' (done)} (size+1)$' '
