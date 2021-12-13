lines =: cutopen 1!:1 <'/tmp/test'
grid =: 0"."0 every lines

bot =: grid < 1 |.!.10 grid
top =: grid < |.!.10 grid
right =: grid < 1 |.!.10 &. |: grid
left =: grid < |.!.10 &. |: grid

low =: bot *. top *. right *. left


out =: +/+/low * (grid+1)


NB. roll downhill, say left for now
NB. current value if leftward isn't lower
NB. plus
NB. right value if right is higher


l =: {{ 1 |.!. x &. |: y }}
r =: {{ |.!. x &. |: y }}

up =: {{ 1 |.!. x y }}
d =: {{ |.!. x y }}

NB. x is heights, y is smoke amount
settle =: 4 : 0
grid =. x
values =. y
stopped =. values * (grid <: _ up grid)
moved =. (0 d values) * (grid < _ d grid)
stopped + moved
)

NB. this is a neat use of under
NB. wonder if I can DRY a bit more
NB. turn grid&settle part into adverb
sd =: grid&settle
su =: grid&(settle &.: |.)
sr =: grid&(settle &.: |:)
sl =: grid&(settle &.: ( |. &: |:))

shake =: {{ grid&(settle &.: u) }}
su2 =: |.shake
NB. etc
ts =: ]`|.`|:`(|.&:|:)

cycle =: {{ sd su sr sl y }}

init =: grid ~: 9

final =: cycle^:_ init

NB. pick nonzero items
nz =: ] #~ 0 ~: ]

nz2 =: {{ y #~ 0 ~: y }}

NB. only works for nonnegative values probably
nz3 =: * # ]

nz4 =: 0&< # ]

basins =: nz ;final

out =: */ 3 {. \:~ basins
