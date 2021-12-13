file=: cutopen 1!:1 <'/tmp/test'
input =: 0".> ',' splitstring&> 0 2 {"1 cutopen&> cutopen file


hv =:  +./"1 =/"2 input

range =: {{< (x <. y) + i. (* y-x) * >: | y - x}}

NB. i. one wider, works for negative too
ix =: [: i. * * 1+|
NB. or explicit
ix =: {{i.(*y)* 1+|y}}


NB. if zero, increment so we actually get an entry
ix2 =: {{i. >:^:(0&=) (*y) * 1+|y}}


NB. reverse if negative instead of signum
ix3 =: {{|.^:(y<0) i. 1+ | y}}

NB. range from x to y inclusive
r =: <. + [: ix3 -~

r2 =: {{< (x<.y) + ix (y-x) }}


lines =: hv # input


h =: {:"1 =/"2 input
v =: 1 0 -:"1 =/"2 input


NB. implement for horizontal lines
NB. swap columns to do vertical

xs =: {{range/"1 {."1 y}}
ys =: {{ {:"1 {."2 y }}

pts =: {{ ;(xs y) {{< (>x) ,. y}}"0 ys y }}



hpts =: pts h#input
vpts =: pts&.:(|."1) v#input


NB. partition, count, find>1
out =: +/1< #/.~ hpts,vpts


diag =: -. h +. v

ds =: xs ,.&> [: xs |."1

NB. to call on multiple, adjust

dpts =: ;<&ds"2 diag#input


out2 =: +/1< #/.~ hpts,vpts,dpts
