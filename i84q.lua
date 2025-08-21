type connection__DARKLUA_TYPE_a={disconnect:()->()}local a a={cache={},load=
function(b)if not a.cache[b]then a.cache[b]={c=a[b]()}end return a.cache[b].c
end}do function a.a()local b={}do local function constructor()return
setmetatable({_map={}},{__index=b})end b.new=constructor function b.fire<T...>(c
,...:T...)for d=#c,1,-1 do local e=c[d]if e then if'function'==type(e)then
coroutine.wrap(e)(...)elseif'thread'==type(e)then coroutine.resume(e,...)end end
end return c end function b.connect<T...>(c,d:(T...)->()):
connection__DARKLUA_TYPE_a table.insert(c,d)return{disconnect=function()local e=
table.find(c,d)if e then table.remove(c,e)end end}end function b.once<T...>(c,d:
(T...)->()):connection__DARKLUA_TYPE_a local e do e=c:connect(function(...)d(...
)e:disconnect()end)end return e end function b.wait<T...>(c):T...local d=
coroutine.running()c:once(function(...)coroutine.resume(d,...)end)return
coroutine.yield()end setmetatable(b,{__call=constructor})end return b end
function a.b()local b={}do function b.connect(c:string)local d=
websocket_connect(c)local e={}do local f={}function e.send(g,h:string)assert(
'string'==type(h),`websocket:send: message must be a string, got {type(h)}`)
websocket_send(d,h)end function e.on(g,h)assert('function'==type(h),`websocket:on: callback must be a function, got {
type(h)}`)table.insert(f,h)return{disconnect=function()assert('function'==type(h
),`connection:disconnect: callback must be a function, got {type(h)}`)local i=
table.find(f,h)if i then table.remove(f,i)end end}end function e.close(g)
websocket_close(d)end websocket_onmessage(d,function(...)for g,h in f do h(...)
end end)end return e end end return b end function a.c()local b={}do
local function constructor(c:number,d:number,e:number)assert('number'==type(c),`Color3.new: red must be a number, got {
type(c)}`)assert('number'==type(d),`Color3.new: green must be a number, got {
type(d)}`)assert('number'==type(e),`Color3.new: blue must be a number, got {
type(e)}`)return setmetatable({c,d,e},{__index=b.__index,__tostring=b.__tostring
})end function b.toHSV(c)local d,e,f=c[1]/255,c[2]/255,c[3]/255 local g,h=math.
max(d,e,f),math.min(d,e,f)local i,j,k k=g local l=g-h if g~=0 then j=l/g else j=
0 i=0 return i,j,k end if d==g then i=(e-f)/l elseif e==g then i=2+(f-d)/l else
i=4+(d-e)/l end i=i*60 if i<0 then i=i+360 end return i,j,k end function b.toHex
(c)local d=string.format('%02X',math.floor(c[1]))local e=string.format('%02X',
math.floor(c[2]))local f=string.format('%02X',math.floor(c[3]))return`{d}{e}{f}`
end function b.new(c:number,d:number,e:number):Color3 assert('number'==type(c),`Color3.new: red must be a number, got {
type(c)}`)assert('number'==type(d),`Color3.new: green must be a number, got {
type(d)}`)assert('number'==type(e),`Color3.new: blue must be a number, got {
type(e)}`)return constructor(c*255,d*255,e*255)end function b.fromRGB(c:number,d
:number,e:number):Color3 assert('number'==type(c),`Color3.fromRGB: red must be a number, got {
type(c)}`)assert('number'==type(d),`Color3.fromRGB: green must be a number, got {
type(d)}`)assert('number'==type(e),`Color3.fromRGB: blue must be a number, got {
type(e)}`)return constructor(c,d,e)end do local c=b.fromRGB function b.fromHex(d
:string)assert('string'==type(d),`Color3.fromHex: data must be a string, got {
type(d)}`)local e=tonumber(d:sub(1,2),16)local f=tonumber(d:sub(3,4),16)local g=
tonumber(d:sub(5,6),16)return c(e,f,g)end function b.fromHSV(d,e,f)assert(type(d
)=='number'and type(e)=='number'and type(f)=='number',
'HSV values must be numbers')d=math.clamp(d,0,360)e=math.clamp(e,0,1)f=math.
clamp(f,0,1)local g=f*e local h=g*(1-math.abs((d/60)%2-1))local i=f-g local j,k,
l if d<60 then j,k,l=g,h,0 elseif d<120 then j,k,l=h,g,0 elseif d<180 then j,k,l
=0,g,h elseif d<240 then j,k,l=0,h,g elseif d<300 then j,k,l=h,0,g else j,k,l=g,
0,h end return c(math.floor((j+i)*255),math.floor((k+i)*255),math.floor((l+i)*
255))end end function b.buffer(c:buffer|typeof(b))assert('buffer'==type(c)or
'table'==type(c),`Color3.buffer: value must be a buffer or Color3, got {type(c)}`
)if'buffer'==type(c)then local d=buffer.readi8(c,0)local e=buffer.readi8(c,1)
local f=buffer.readi16(c,2)return b.fromRGB(d,e,f)else local d=buffer.create(8)
buffer.writei8(d,0,c[1])buffer.writei8(d,1,c[2])buffer.writei16(d,2,c[3])return
d end end function b.dword(c:number|typeof(b))assert('number'==type(c)or'table'
==type(c),`Color3.dword: value must be a number or Color3, got {type(c)}`)if
'number'==type(c)then return b.fromRGB(bit32.band(c,0xff),bit32.band(bit32.
rshift(c,8),0xff),bit32.band(bit32.rshift(c,16),0xff))else return bit32.bor(c[1]
,bit32.lshift(c[2],8),bit32.lshift(c[3],16))end end function b.__index(c,d:
string)if d:lower()=='r'then return c[1]elseif d:lower()=='g'then return c[2]
elseif d:lower()=='b'then return c[3]end return rawget(c,d)or b[d]end function b
.__newindex(c,d:string,e:any)if d:lower()=='r'then c[1]=e elseif d:lower()=='g'
then c[2]=e elseif d:lower()=='b'then c[3]=e else rawset(c,d,e)end end function
b.__eq(c,d)return c[1]==d[1]and c[2]==d[2]and c[3]==d[3]end function b.
__tostring(c)return`Color3.fromRGB({c[1]}, {c[2]}, {c[3]})`end end local c={
Palette={[1032]={Name='Hot pink',Color=b.fromRGB(255,0,191)},[1031]={Name=
'Royal purple',Color=b.fromRGB(98,37,209)},[1030]={Name='Pastel brown',Color=b.
fromRGB(255,204,153)},[1029]={Name='Pastel yellow',Color=b.fromRGB(255,255,204)}
,[1028]={Name='Pastel green',Color=b.fromRGB(204,255,204)},[1027]={Name=
'Pastel blue-green',Color=b.fromRGB(159,243,233)},[1026]={Name='Pastel violet',
Color=b.fromRGB(177,167,255)},[1025]={Name='Pastel orange',Color=b.fromRGB(255,
201,201)},[1024]={Name='Pastel light blue',Color=b.fromRGB(175,221,255)},[1023]=
{Name='Lavender',Color=b.fromRGB(140,91,159)},[1022]={Name='Grime',Color=b.
fromRGB(127,142,100)},[1021]={Name='Camo',Color=b.fromRGB(58,125,21)},[1020]={
Name='Lime green',Color=b.fromRGB(0,255,0)},[1019]={Name='Toothpaste',Color=b.
fromRGB(0,255,255)},[1018]={Name='Teal',Color=b.fromRGB(18,238,212)},[1017]={
Name='Deep orange',Color=b.fromRGB(255,175,0)},[1016]={Name='Pink',Color=b.
fromRGB(255,102,204)},[1015]={Name='Magenta',Color=b.fromRGB(170,0,170)},[1014]=
{Name='CGA brown',Color=b.fromRGB(170,85,0)},[1013]={Name='Cyan',Color=b.
fromRGB(4,175,236)},[1012]={Name='Deep blue',Color=b.fromRGB(33,84,185)},[1011]=
{Name='Navy blue',Color=b.fromRGB(0,32,96)},[1010]={Name='Really blue',Color=b.
fromRGB(0,0,255)},[1009]={Name='New Yeller',Color=b.fromRGB(255,255,0)},[1008]={
Name='Olive',Color=b.fromRGB(193,190,66)},[1007]={Name='Dusty Rose',Color=b.
fromRGB(163,75,75)},[1006]={Name='Alder',Color=b.fromRGB(180,128,255)},[1005]={
Name='Deep orange',Color=b.fromRGB(255,176,0)},[1004]={Name='Really red',Color=b
.fromRGB(255,0,0)},[1003]={Name='Really black',Color=b.fromRGB(17,17,17)},[1002]
={Name='Mid gray',Color=b.fromRGB(205,205,205)},[1001]={Name=
'Institutional white',Color=b.fromRGB(248,248,248)},[365]={Name='Burnt Sienna',
Color=b.fromRGB(106,57,9)},[364]={Name='Dark taupe',Color=b.fromRGB(90,76,66)},[
363]={Name='Flint',Color=b.fromRGB(105,102,92)},[362]={Name='Bronze',Color=b.
fromRGB(126,104,63)},[361]={Name='Medium brown',Color=b.fromRGB(86,66,54)},[360]
={Name='Copper',Color=b.fromRGB(150,103,102)},[359]={Name='Linen',Color=b.
fromRGB(175,148,131)},[358]={Name='Cloudy grey',Color=b.fromRGB(171,168,158)},[
357]={Name='Hurricane grey',Color=b.fromRGB(149,137,136)},[356]={Name=
'Fawn brown',Color=b.fromRGB(160,132,79)},[355]={Name='Pine Cone',Color=b.
fromRGB(108,88,75)},[354]={Name='Oyster',Color=b.fromRGB(187,179,178)},[353]={
Name='Beige',Color=b.fromRGB(202,191,163)},[352]={Name='Burlap',Color=b.fromRGB(
199,172,120)},[351]={Name='Cork',Color=b.fromRGB(188,155,93)},[350]={Name=
'Burgundy',Color=b.fromRGB(136,62,62)},[349]={Name='Seashell',Color=b.fromRGB(
233,218,218)},[348]={Name='Lily white',Color=b.fromRGB(237,234,234)},[347]={Name
='Khaki',Color=b.fromRGB(226,220,188)},[346]={Name='Cashmere',Color=b.fromRGB(
211,190,150)},[345]={Name='Rust',Color=b.fromRGB(143,76,42)},[344]={Name='Tawny'
,Color=b.fromRGB(150,85,85)},[343]={Name='Sunrise',Color=b.fromRGB(212,144,189)}
,[342]={Name='Mauve',Color=b.fromRGB(224,178,208)},[341]={Name='Buttermilk',
Color=b.fromRGB(254,243,187)},[340]={Name='Wheat',Color=b.fromRGB(241,231,199)},
[339]={Name='Cocoa',Color=b.fromRGB(86,36,36)},[338]={Name='Terra Cotta',Color=b
.fromRGB(190,104,98)},[337]={Name='Salmon',Color=b.fromRGB(255,148,148)},[336]={
Name='Fog',Color=b.fromRGB(199,212,228)},[335]={Name='Pearl',Color=b.fromRGB(231
,231,236)},[334]={Name='Daisy orange',Color=b.fromRGB(248,217,109)},[333]={Name=
'Gold',Color=b.fromRGB(239,184,56)},[332]={Name='Maroon',Color=b.fromRGB(117,0,0
)},[331]={Name='Persimmon',Color=b.fromRGB(255,89,89)},[330]={Name=
'Carnation pink',Color=b.fromRGB(255,152,220)},[329]={Name='Baby blue',Color=b.
fromRGB(152,194,219)},[328]={Name='Mint',Color=b.fromRGB(177,229,166)},[327]={
Name='Crimson',Color=b.fromRGB(151,0,0)},[325]={Name='Quill grey',Color=b.
fromRGB(223,223,222)},[324]={Name='Laurel green',Color=b.fromRGB(168,189,153)},[
323]={Name='Olivine',Color=b.fromRGB(148,190,129)},[322]={Name='Plum',Color=b.
fromRGB(123,47,123)},[321]={Name='Lilac',Color=b.fromRGB(167,94,155)},[320]={
Name='Ghost grey',Color=b.fromRGB(202,203,209)},[319]={Name='Sage green',Color=b
.fromRGB(185,196,177)},[318]={Name='Artichoke',Color=b.fromRGB(138,171,133)},[
317]={Name='Moss',Color=b.fromRGB(124,156,107)},[316]={Name='Eggplant',Color=b.
fromRGB(123,0,123)},[315]={Name='Electric blue',Color=b.fromRGB(9,137,207)},[314
]={Name='Cadet blue',Color=b.fromRGB(159,173,192)},[313]={Name='Forest green',
Color=b.fromRGB(31,128,29)},[312]={Name='Mulberry',Color=b.fromRGB(89,34,89)},[
311]={Name='Fossil',Color=b.fromRGB(159,161,172)},[310]={Name='Shamrock',Color=b
.fromRGB(91,154,76)},[309]={Name='Sea green',Color=b.fromRGB(52,142,64)},[308]={
Name='Dark indigo',Color=b.fromRGB(61,21,133)},[307]={Name='Lapis',Color=b.
fromRGB(16,42,220)},[306]={Name='Storm blue',Color=b.fromRGB(51,88,130)},[305]={
Name='Steel blue',Color=b.fromRGB(82,124,174)},[304]={Name='Parsley green',Color
=b.fromRGB(44,101,29)},[303]={Name='Dark blue',Color=b.fromRGB(0,16,176)},[302]=
{Name='Smoky grey',Color=b.fromRGB(91,93,105)},[301]={Name='Slime green',Color=b
.fromRGB(80,109,84)},[268]={Name='Medium lilac',Color=b.fromRGB(52,43,117)},[232
]={Name='Dove blue',Color=b.fromRGB(125,187,221)},[226]={Name='Cool yellow',
Color=b.fromRGB(253,234,141)},[225]={Name='Warm yellowish orange',Color=b.
fromRGB(235,184,127)},[224]={Name='Light brick yellow',Color=b.fromRGB(240,213,
160)},[223]={Name='Light pink',Color=b.fromRGB(220,144,149)},[222]={Name=
'Light purple',Color=b.fromRGB(228,173,200)},[221]={Name='Bright purple',Color=b
.fromRGB(205,98,152)},[220]={Name='Light lilac',Color=b.fromRGB(167,169,206)},[
219]={Name='Lilac',Color=b.fromRGB(107,98,155)},[218]={Name='Reddish lilac',
Color=b.fromRGB(150,112,159)},[217]={Name='Brown',Color=b.fromRGB(124,92,70)},[
216]={Name='Rust',Color=b.fromRGB(144,76,42)},[213]={Name='Medium Royal blue',
Color=b.fromRGB(108,129,183)},[212]={Name='Light Royal blue',Color=b.fromRGB(159
,195,233)},[211]={Name='Turquoise',Color=b.fromRGB(121,181,181)},[210]={Name=
'Faded green',Color=b.fromRGB(112,149,120)},[209]={Name='Dark Curry',Color=b.
fromRGB(176,142,68)},[208]={Name='Light stone grey',Color=b.fromRGB(229,228,223)
},[200]={Name='Lemon metalic',Color=b.fromRGB(130,138,93)},[199]={Name=
'Dark stone grey',Color=b.fromRGB(99,95,98)},[198]={Name='Bright reddish lilac',
Color=b.fromRGB(142,66,133)},[196]={Name='Dark Royal blue',Color=b.fromRGB(35,71
,139)},[195]={Name='Royal blue',Color=b.fromRGB(70,103,164)},[193]={Name=
'Flame reddish orange',Color=b.fromRGB(207,96,36)},[192]={Name='Reddish brown',
Color=b.fromRGB(105,64,40)},[191]={Name='Flame yellowish orange',Color=b.
fromRGB(232,171,45)},[190]={Name='Fire Yellow',Color=b.fromRGB(249,214,46)},[180
]={Name='Curry',Color=b.fromRGB(215,169,75)},[179]={Name='Silver flip/flop',
Color=b.fromRGB(137,135,136)},[178]={Name='Yellow flip/flop',Color=b.fromRGB(180
,132,85)},[176]={Name='Red flip/flop',Color=b.fromRGB(151,105,91)},[168]={Name=
'Gun metallic',Color=b.fromRGB(117,108,98)},[158]={Name='Tr. Flu. Red',Color=b.
fromRGB(225,164,194)},[157]={Name='Tr. Flu. Yellow',Color=b.fromRGB(255,246,123)
},[154]={Name='Dark red',Color=b.fromRGB(123,46,47)},[153]={Name='Sand red',
Color=b.fromRGB(149,121,119)},[151]={Name='Sand green',Color=b.fromRGB(120,144,
130)},[150]={Name='Light grey metallic',Color=b.fromRGB(171,173,172)},[149]={
Name='Black metallic',Color=b.fromRGB(22,29,50)},[148]={Name=
'Dark grey metallic',Color=b.fromRGB(87,88,87)},[147]={Name=
'Sand yellow metallic',Color=b.fromRGB(147,135,103)},[146]={Name=
'Sand violet metallic',Color=b.fromRGB(149,142,163)},[145]={Name=
'Sand blue metallic',Color=b.fromRGB(121,136,161)},[143]={Name='Tr. Flu. Blue',
Color=b.fromRGB(207,226,247)},[141]={Name='Earth green',Color=b.fromRGB(39,70,45
)},[140]={Name='Earth blue',Color=b.fromRGB(32,58,86)},[138]={Name='Sand yellow'
,Color=b.fromRGB(149,138,115)},[137]={Name='Medium orange',Color=b.fromRGB(224,
152,100)},[136]={Name='Sand violet',Color=b.fromRGB(135,124,144)},[135]={Name=
'Sand blue',Color=b.fromRGB(116,134,157)},[134]={Name='Neon green',Color=b.
fromRGB(216,221,86)},[133]={Name='Neon orange',Color=b.fromRGB(213,115,61)},[131
]={Name='Silver',Color=b.fromRGB(156,163,168)},[128]={Name='Dark nougat',Color=b
.fromRGB(174,122,89)},[127]={Name='Gold',Color=b.fromRGB(220,188,129)},[126]={
Name='Tr. Bright bluish violet',Color=b.fromRGB(165,165,203)},[125]={Name=
'Light orange',Color=b.fromRGB(234,184,146)},[124]={Name='Bright reddish violet'
,Color=b.fromRGB(146,57,120)},[123]={Name='Br. reddish orange',Color=b.fromRGB(
211,111,76)},[121]={Name='Med. yellowish orange',Color=b.fromRGB(231,172,88)},[
120]={Name='Lig. yellowish green',Color=b.fromRGB(217,228,167)},[119]={Name=
'Br. yellowish green',Color=b.fromRGB(164,189,71)},[118]={Name=
'Light bluish green',Color=b.fromRGB(183,215,213)},[116]={Name=
'Med. bluish green',Color=b.fromRGB(85,165,175)},[115]={Name=
'Med. yellowish green',Color=b.fromRGB(199,210,60)},[113]={Name=
'Tr. Medi. reddish violet',Color=b.fromRGB(229,173,200)},[112]={Name=
'Medium bluish violet',Color=b.fromRGB(104,116,172)},[111]={Name='Tr. Brown',
Color=b.fromRGB(191,183,177)},[110]={Name='Bright bluish violet',Color=b.
fromRGB(67,84,147)},[108]={Name='Earth yellow',Color=b.fromRGB(104,92,67)},[107]
={Name='Bright bluish green',Color=b.fromRGB(0,143,156)},[106]={Name=
'Bright orange',Color=b.fromRGB(218,133,65)},[105]={Name='Br. yellowish orange',
Color=b.fromRGB(226,155,64)},[104]={Name='Bright violet',Color=b.fromRGB(107,50,
124)},[103]={Name='Light grey',Color=b.fromRGB(199,193,183)},[102]={Name=
'Medium blue',Color=b.fromRGB(110,153,202)},[101]={Name='Medium red',Color=b.
fromRGB(218,134,122)},[100]={Name='Light red',Color=b.fromRGB(238,196,182)},[50]
={Name='Phosph. White',Color=b.fromRGB(236,232,222)},[49]={Name='Tr. Flu. Green'
,Color=b.fromRGB(248,241,132)},[48]={Name='Tr. Green',Color=b.fromRGB(132,182,
141)},[47]={Name='Tr. Flu. Reddish orange',Color=b.fromRGB(217,133,108)},[45]={
Name='Light blue',Color=b.fromRGB(180,210,228)},[44]={Name='Tr. Yellow',Color=b.
fromRGB(247,241,141)},[43]={Name='Tr. Blue',Color=b.fromRGB(123,182,232)},[42]={
Name='Tr. Lg blue',Color=b.fromRGB(193,223,240)},[41]={Name='Tr. Red',Color=b.
fromRGB(205,84,75)},[40]={Name='Transparent',Color=b.fromRGB(236,236,236)},[39]=
{Name='Light bluish violet',Color=b.fromRGB(193,202,222)},[38]={Name=
'Dark orange',Color=b.fromRGB(160,95,53)},[37]={Name='Bright green',Color=b.
fromRGB(75,151,75)},[36]={Name='Lig. Yellowich orange',Color=b.fromRGB(243,207,
155)},[29]={Name='Medium green',Color=b.fromRGB(161,196,140)},[28]={Name=
'Dark green',Color=b.fromRGB(40,127,71)},[27]={Name='Dark grey',Color=b.fromRGB(
109,110,108)},[26]={Name='Black',Color=b.fromRGB(27,42,53)},[25]={Name=
'Earth orange',Color=b.fromRGB(98,71,50)},[24]={Name='Bright yellow',Color=b.
fromRGB(245,205,48)},[23]={Name='Bright blue',Color=b.fromRGB(13,105,172)},[22]=
{Name='Med. reddish violet',Color=b.fromRGB(196,112,160)},[21]={Name=
'Bright red',Color=b.fromRGB(196,40,28)},[18]={Name='Nougat',Color=b.fromRGB(204
,142,105)},[12]={Name='Light orange brown',Color=b.fromRGB(203,132,66)},[11]={
Name='Pastel Blue',Color=b.fromRGB(128,187,219)},[9]={Name=
'Light reddish violet',Color=b.fromRGB(232,186,200)},[6]={Name=
'Light green (Mint)',Color=b.fromRGB(194,218,184)},[5]={Name='Brick yellow',
Color=b.fromRGB(215,197,154)},[4]={Name='Medium stone grey',Color=b.fromRGB(163,
162,165)},[3]={Name='Light yellow',Color=b.fromRGB(249,233,153)},[2]={Name=
'Grey',Color=b.fromRGB(161,165,162)},[1]={Name='White',Color=b.fromRGB(242,243,
243)}}}do local d={}do for e,f in pairs(c.Palette)do d[f.Name:lower()]=e end end
local e={}do for f in c.Palette do table.insert(e,f)end end function c.new(f)
local g=setmetatable({},c)if type(f)=='number'then local h=c.Palette[f]or c.
Palette[4]g.Name=h.Name g.Color=h.Color g.Index=f elseif type(f)=='string'then
local h=d[f:lower()]if h then local i=c.Palette[h]g.Index=h g.Color=i.Color g.
Name=i.Name else error(`invalid BrickColor: {f}`)end elseif type(f)=='table'then
if not f[1]or not f[2]or not f[3]then error(`BrickColor.new: can't initialize BrickColor, invalid Color3`
)end local h,i=(math.huge)for j,k in c.Palette do local l=k.Color:distance(f)if
h>l then i=k h=l end end return c.new(i.Name)end return g end function c.random(
)return c.new(e[math.random(1,#e)])end function c.__tostring(f)return f.Name end
c.__index=c end _G.BrickColor=c return b end function a.d()local b,c,d,e=math.
abs,math.ceil,math.floor,math.sign local f,g=math.max,math.min local h={}do
local function constructor(i:number,j:number)assert('number'==type(i),`Vector2.new: expected a number for x, got {
type(i)}`)assert('number'==type(j),`Vector2.new: expected a number for y, got {
type(j)}`)return setmetatable({x=i,y=j},h)end h.new=constructor function h.abs(i
)return constructor(b(i.x),b(i.y))end function h.cross(i,j)assert('table'==type(
j)and getmetatable(j)=='Vector2',`Vector2.cross: expected a Vector2, got {type(j
)}`)return i.x*j.y-i.y*j.x end function h.ceil(i)return constructor(c(i.x),c(i.y
))end function h.floor(i)return constructor(d(i.x),d(i.y))end function h.sign(i)
return constructor(e(i.x),e(i.y))end function h.angle(i,j,k:boolean?)assert(
'table'==type(j)and getmetatable(j)=='Vector2',`Vector2.angle: expected a Vector2, got {
type(j)}`)local l=i:dot(j)local m=i.magnitude*j.magnitude if m==0 then return 0
end local n=math.acos(l/m)if k then local o=i:cross(j)if o<0 then n=-n end end
return n end function h.dot(i,j)assert('table'==type(j)and getmetatable(j)==
'Vector2',`Vector2.dot: expected a Vector2, got {type(j)}`)return i.x*j.x+i.y*j.
y end function h.lerp(i,j,k:number)assert('table'==type(j)and getmetatable(j)==
'Vector2',`Vector2.lerp: expected a Vector2, got {type(j)}`)assert('number'==
type(k),`Vector2.lerp: expected a number for alpha, got {type(k)}`)return
constructor(i.x+(j.x-i.x)*k,i.y+(j.y-i.y)*k)end function h.max(i,...)for j,k in{
...}do assert('table'==type(k)and getmetatable(k)=='Vector2',`Vector2.max: expected a Vector2, got {
type(k)}`)i=constructor(f(i.x,k.x),f(i.y,k.y))end return i end function h.min(i,
...)for j,k in{...}do assert('table'==type(k)and getmetatable(k)=='Vector2',`Vector2.min: expected a Vector2, got {
type(k)}`)i=constructor(g(i.x,k.x),g(i.y,k.y))end return i end h.zero=
constructor(0,0)h.one=constructor(1,1)h.xAxis=constructor(1,0)h.yAxis=
constructor(0,1)h.__metatable='Vector2'function h.__add(i,j)if'number'==type(j)
then return constructor(i.x+j,i.y+j)end return constructor(i.x+j.x,i.y+j.y)end
function h.__sub(i,j)if'number'==type(j)then return constructor(i.x-j,i.y-j)end
return constructor(i.x-j.x,i.y-j.y)end function h.__mul(i,j)if'number'==type(j)
then return constructor(i.x*j,i.y*j)end return constructor(i.x*j.x,i.y*j.y)end
function h.__div(i,j)if'number'==type(j)then return constructor(i.x/j,i.y/j)end
return constructor(i.x/j.x,i.y/j.y)end function h.__index(i,j)j=string.lower(j)
if'magnitude'==j then return math.sqrt(i.x*i.x+i.y*i.y)end if'unit'==j then
local k=i.magnitude return k~=0 and constructor(i.x/k,i.y/k)or i end return
rawget(h,j)or i[j]end function h.__tostring(i)return`{i.x}, {i.y}`end end return
table.freeze(h)end function a.e()local b,c,d,e=math.abs,math.ceil,math.floor,
math.sign local f,g=math.max,math.min local h={}do local function constructor(i:
number,j:number,k:number)assert('number'==type(i),`Vector3.new: expected a number for x, got {
type(i)}`)assert('number'==type(j),`Vector3.new: expected a number for y, got {
type(j)}`)assert('number'==type(k),`Vector3.new: expected a number for z, got {
type(k)}`)return setmetatable({x=i,y=j,z=k},h)end h.new=constructor function h.
abs(i)return constructor(b(i.x),b(i.y),b(i.z))end function h.cross(i,j)assert(
'table'==type(j)and getmetatable(j)=='Vector3',`Vector3.cross: expected a Vector3, got {
type(j)}`)return constructor(i.y*j.z-i.z*j.y,i.z*j.x-i.x*j.z,i.x*j.y-i.y*j.x)end
function h.ceil(i)return constructor(c(i.x),c(i.y),c(i.z))end function h.floor(i
)return constructor(d(i.x),d(i.y),d(i.z))end function h.sign(i)return
constructor(e(i.x),e(i.y),e(i.z))end function h.angle(i,j,k:boolean?)assert(
'table'==type(j)and getmetatable(j)=='Vector3',`Vector3.angle: expected a Vector3, got {
type(j)}`)local l=i:dot(j)local m=i.magnitude*j.magnitude if m==0 then return 0
end local n=math.acos(l/m)if k then local o=i:cross(j).z if o<0 then n=-n end
end return n end function h.dot(i,j)assert('table'==type(j)and getmetatable(j)==
'Vector3',`Vector3.dot: expected a Vector3, got {type(j)}`)return i.x*j.x+i.y*j.
y+i.z*j.z end function h.lerp(i,j,k:number)assert('table'==type(j)and
getmetatable(j)=='Vector3',`Vector3.lerp: expected a Vector3, got {type(j)}`)
assert('number'==type(k),`Vector3.lerp: expected a number for alpha, got {type(k
)}`)return constructor(i.x+(j.x-i.x)*k,i.y+(j.y-i.y)*k,i.z+(j.z-i.z)*k)end
function h.max(i,...)for j,k in{...}do assert('table'==type(k)and getmetatable(k
)=='Vector3',`Vector3.max: expected a Vector3, got {type(k)}`)i=constructor(f(i.
x,k.x),f(i.y,k.y),f(i.z,k.z))end return i end function h.min(i,...)for j,k in{
...}do assert('table'==type(k)and getmetatable(k)=='Vector3',`Vector3.min: expected a Vector3, got {
type(k)}`)i=constructor(g(i.x,k.x),g(i.y,k.y),g(i.z,k.z))end return i end
function h.fuzzyeq(i,j,k:number?)assert('table'==type(j)and getmetatable(j)==
'Vector3',`Vector3.fuzzyeq: expected a Vector3, got {type(j)}`)assert('number'==
type(k)or'nil'==type(k),`Vector3.fuzzyeq: expected a number for epsilon, got {
type(k)}`)k=k or 0.0001 return b(i.x-j.x)<=k and b(i.y-j.y)<=k and b(i.z-j.z)<=k
end h.zero=constructor(0,0,0)h.one=constructor(1,1,1)h.xAxis=constructor(1,0,0)h
.yAxis=constructor(0,1,0)h.zAxis=constructor(0,0,1)h.__metatable='Vector3'
function h.__add(i,j)if'number'==type(j)then return constructor(i.x+j,i.y+j,i.z+
j)end return constructor(i.x+j.x,i.y+j.y,i.z+j.z)end function h.__sub(i,j)if
'number'==type(j)then return constructor(i.x-j,i.y-j,i.z-j)end return
constructor(i.x-j.x,i.y-j.y,i.z-j.z)end function h.__mul(i,j)if'number'==type(j)
then return constructor(i.x*j,i.y*j,i.z*j)end return constructor(i.x*j.x,i.y*j.y
,i.z*j.z)end function h.__div(i,j)if'number'==type(j)then return constructor(i.x
/j,i.y/j,i.z/j)end return constructor(i.x/j.x,i.y/j.y,i.z/j.z)end function h.
__idiv(i,j)if'number'==type(j)then return constructor(d(i.x//j),d(i.y//j),d(i.z
//j))end return constructor(d(i.x//j.x),d(i.y//j.y),d(i.z//j.z))end function h.
__index(i,j)j=string.lower(j)if'magnitude'==j then return math.sqrt(i.x*i.x+i.y*
i.y+i.z*i.z)end if'unit'==j then local k=i.magnitude return k~=0 and
constructor(i.x/k,i.y/k,i.z/k)or i end return rawget(h,j)or i[j]end function h.
__tostring(i)return`{i.x}, {i.y}, {i.z}`end end return table.freeze(h)end
function a.f()local b=a.load'c'local c=a.load'd'local d=a.load'e'local e=
function(e:any,f:number,g:string)if'color'==g then local h=getmemoryvalue(e,f,
'dword')return h and b.dword(h)end if'userdata'==g then local h=getmemoryvalue(e
,f,'qword')return h and pointer_to_user_data(h)end if'object'==g then assert(
Instance,`memory.get: 'Instance' is not available, can't read object`)local h=
getmemoryvalue(e,f,'qword')local i=h and pointer_to_user_data(h)return i and
'none'~=getclassname(i):lower()and Instance.new(i)end if'buffer'==g then local h
=getmemoryvalue(e,f,'qword')return h and buffer.fromstring(string.pack('<I8',h))
end if'vector'==g then local h=getmemoryvalue(e,f,'float')local i=
getmemoryvalue(e,f+4,'float')local j=getmemoryvalue(e,f+8,'float')return vector.
create(h,i,j)end if'Vector2'==g then local h=getmemoryvalue(e,f,'float')local i=
getmemoryvalue(e,f+4,'float')return c.create(h,i)end if'Vector3'==g then local h
=getmemoryvalue(e,f,'float')local i=getmemoryvalue(e,f+4,'float')local j=
getmemoryvalue(e,f+8,'float')return d.create(h,i,j)end return getmemoryvalue(e,f
,g::any)end local f=function(f:any,g:number,h:string,i:any)if'color'==h and
'table'==type(i)and i.dword then return setmemoryvalue(f,g,'dword',i:dword())end
if'userdata'==h then i=tostring(i)if'string'==type(i)and i:match'^0x'then i=
tonumber(i:sub(3),16)end return setmemoryvalue(f,g,'qword',i)end if'object'==h
and type(i)=='table'and i.Data then i=tostring(i.Data)if'string'==type(i)and i:
match'^0x'then i=tonumber(i:sub(3),16)end return setmemoryvalue(f,g,'qword',i)
end if'buffer'==h and'buffer'==type(i)then return setmemoryvalue(f,g,i,'qword')
end if'vector'==h and'vector'==type(i)then local j=i.X or i[1]local k=i.Y or i[2
]local l=i.Z or i[3]setmemoryvalue(f,g,j,'float')setmemoryvalue(f,g+4,k,'float')
setmemoryvalue(f,g+8,l,'float')return true end return setmemoryvalue(f,g,i,h::
any)end local g={}do function g.read(h:number|any,i:number|string,j:string?)if
'table'==type(h)and rawget(h,'Data')then h=h.Data end if'userdata'==type(h)then
assert('number'==type(i),`memory.read: offset must be a number, got {type(i)}`)
assert('string'==type(j)or not j,`memory.read: spec must be a string or nil, got {
type(j)}`)return e(h,i,j::any)end if'number'==type(h)then if'string'==type(i)
then return e(pointer_to_user_data(h),0,i::any)else assert('number'==type(i),`memory.read: offset must be a number or a string, got {
type(i)}`)assert('string'==type(j)or not j,`memory.read: spec must be a string or nil, got {
type(j)}`)return e(pointer_to_user_data(h),i,j::any)end end return nil end
function g.write(h:number|any,i:number|string,j:string?,k:any)if'table'==type(h)
and rawget(h,'Data')then h=h.Data end if'userdata'==type(h)then assert('number'
==type(i),`memory.write: offset must be a number, got {type(i)}`)assert('string'
==type(j)or not j,`memory.write: spec must be a string or nil, got {type(j)}`)
return f(h,i,j::any,k)end if'number'==type(h)then if'string'==type(i)then return
f(pointer_to_user_data(h),0,i::any,k)else assert('number'==type(i),`memory.write: offset must be a number or a string, got {
type(i)}`)assert('string'==type(j)or not j,`memory.write: spec must be a string or nil, got {
type(j)}`)return f(pointer_to_user_data(h),i,j::any,k)end end return nil end end
return g end function a.g()return{decode=function(b)return JSONDecode(b)end,
encode=function(b)return JSONEncode(b)end}end function a.h()return{get=function(
b,c)assert('table'==type(b),`http.get: settings must be a table, got {type(b)}`)
assert('function'==type(c),`http.get: callback must be a function, got {type(c)}`
)spawn(function()return c(httpget(unpack(b)))end)end,post=function(b,c)assert(
'table'==type(b),`http.get: settings must be a table, got {type(b)}`)assert(
'function'==type(c),`http.get: callback must be a function, got {type(c)}`)
spawn(function()return c(httpget(unpack(b)))end)end}end function a.i()return
function(b,c)assert('table'==type(b),`map(t, callback): expected a table, got {
type(b)}`)assert('function'==type(c),`map(t, callback): expected a function, got {
type(c)}`)local d={}do for e,f in b do d[e]=c(f,e,b)end end return d end end
function a.j()local b=a.load'e'local c,d,e,f=math.abs,math.sqrt,math.sin,math.
cos local g,h,i=math.acos,math.atan2,math.clamp local function isVector3(j)
return'table'==type(j)and getmetatable(j)=='Vector3'end local function isCFrame(
j)return'table'==type(j)and getmetatable(j)=='CFrame'end local j={}do
local function constructor(k:number,l:number,m:number,n:number?,o:number?,p:
number?,q:number?,r:number?,s:number?,t:number?,u:number?,v:number?)assert(
'number'==type(k),`CFrame.new: expected a number for x, got {type(k)}`)assert(
'number'==type(l),`CFrame.new: expected a number for y, got {type(l)}`)assert(
'number'==type(m),`CFrame.new: expected a number for z, got {type(m)}`)n=n or 1
o=o or 0 p=p or 0 q=q or 0 r=r or 1 s=s or 0 t=t or 0 u=u or 0 v=v or 1 return
setmetatable({x=k,y=l,z=m,r00=n,r01=o,r02=p,r10=q,r11=r,r12=s,r20=t,r21=u,r22=v}
,j)end local function fromQuaternion(k,l,m,n,o,p,q)local r=d(n*n+o*o+p*p+q*q)if
r==0 then return constructor(k,l,m)end n,o,p,q=n/r,o/r,p/r,q/r local s,t,u=n*n,o
*o,p*p local v,w,x=n*o,n*p,o*p local y,z,A=q*n,q*o,q*p local B=1-2*(t+u)local C=
2*(v+A)local D=2*(w-z)local E=2*(v-A)local F=1-2*(s+u)local G=2*(x+y)local H=2*(
w+z)local I=2*(x-y)local J=1-2*(s+t)return constructor(k,l,m,B,C,D,E,F,G,H,I,J)
end local function toQuaternion(k)local l,m,n=k.r00,k.r01,k.r02 local o,p,q=k.
r10,k.r11,k.r12 local r,s,t=k.r20,k.r21,k.r22 local u=l+p+t local v,w,x,y if u>0
then local z=d(u+1)*2 v=0.25*z w=(s-q)/z x=(n-r)/z y=(o-m)/z elseif l>p and l>t
then local z=d(1+l-p-t)*2 v=(s-q)/z w=0.25*z x=(m+o)/z y=(n+r)/z elseif p>t then
local z=d(1+p-l-t)*2 v=(n-r)/z w=(m+o)/z x=0.25*z y=(q+s)/z else local z=d(1+t-l
-p)*2 v=(o-m)/z w=(n+r)/z x=(q+s)/z y=0.25*z end local z=d(w*w+x*x+y*y+v*v)if z
==0 then return 0,0,0,1 end return w/z,x/z,y/z,v/z end local function slerp(k,l,
m,n,o,p,q,r,s)local t=k*o+l*p+m*q+n*r if t<0 then o,p,q,r=-o,-p,-q,-r t=-t end
local u=1e-6 if t>1-u then local v=k+(o-k)*s local w=l+(p-l)*s local x=m+(q-m)*s
local y=n+(r-n)*s local z=d(v*v+w*w+x*x+y*y)return v/z,w/z,x/z,y/z end local v=
g(i(t,-1,1))local w=e(v)local x=v*s local y=e(x)local z=f(x)-t*y/w local A=y/w
local B=z*k+A*o local C=z*l+A*p local D=z*m+A*q local E=z*n+A*r return B,C,D,E
end local function matMul(k,l)return k.r00*l.r00+k.r01*l.r10+k.r02*l.r20,k.r00*l
.r01+k.r01*l.r11+k.r02*l.r21,k.r00*l.r02+k.r01*l.r12+k.r02*l.r22,k.r10*l.r00+k.
r11*l.r10+k.r12*l.r20,k.r10*l.r01+k.r11*l.r11+k.r12*l.r21,k.r10*l.r02+k.r11*l.
r12+k.r12*l.r22,k.r20*l.r00+k.r21*l.r10+k.r22*l.r20,k.r20*l.r01+k.r21*l.r11+k.
r22*l.r21,k.r20*l.r02+k.r21*l.r12+k.r22*l.r22 end local function rotTranspose(k)
return k.r00,k.r10,k.r20,k.r01,k.r11,k.r21,k.r02,k.r12,k.r22 end local function
rotateVec(k,l)return b.new(k.r00*l.x+k.r01*l.y+k.r02*l.z,k.r10*l.x+k.r11*l.y+k.
r12*l.z,k.r20*l.x+k.r21*l.y+k.r22*l.z)end local function rotateVecT(k,l)return b
.new(k.r00*l.x+k.r10*l.y+k.r20*l.z,k.r01*l.x+k.r11*l.y+k.r21*l.z,k.r02*l.x+k.r12
*l.y+k.r22*l.z)end local function columnsFromEuler(k,l,m,n)n=string.upper(n or
'XYZ')local o,p=f(k),e(k)local q,r=f(l),e(l)local s,t=f(m),e(m)local function
matXYZ()local u=q*s local v=o*t+p*r*s local w=p*t-o*r*s local x=-q*t local y=o*s
-p*r*t local z=p*s+o*r*t local A=r local B=-p*q local C=o*q return u,v,w,x,y,z,A
,B,C end local function matYXZ()local u=q*s+r*p*t local v=o*t local w=q*p*t-r*s
local x=r*s-q*p*t local y=o*s local z=r*p*t+q*s local A=p*r local B=-p local C=o
*q return u,v,w,x,y,z,A,B,C end if n=='XYZ'then return matXYZ()elseif n=='YXZ'
then return matYXZ()else return matXYZ()end end j.new=function(...)local k=
select('#',...)if k==0 then return constructor(0,0,0)end local l=select(1,...)if
k==1 and isVector3(l)then return constructor(l.x,l.y,l.z)end if k==2 and
isVector3(l)and isVector3(select(2,...))then local m=l::any local n=select(2,...
)::any return j.lookAt(m,n)end if k==3 then local m,n,o=l,select(2,...),select(3
,...)assert('number'==type(m)and'number'==type(n)and'number'==type(o),`CFrame.new: expected numbers for x,y,z, got {
type(m)},{type(n)},{type(o)}`)return constructor(m,n,o)end if k==7 then local m,
n,o,p,q,r,s=l,select(2,...),select(3,...),select(4,...),select(5,...),select(6,
...),select(7,...)assert('number'==type(p)and'number'==type(q)and'number'==type(
r)and'number'==type(s),'CFrame.new: expected quaternion numbers')return
fromQuaternion(m,n,o,p,q,r,s)end if k==12 then local m,n,o,p,q,r,s,t,u,v,w,x=l,
select(2,...),select(3,...),select(4,...),select(5,...),select(6,...),select(7,
...),select(8,...),select(9,...),select(10,...),select(11,...),select(12,...)
return constructor(m,n,o,p,q,r,s,t,u,v,w,x)end return error
'CFrame.new: invalid arguments'end function j.lookAt(k,l,m)assert(isVector3(k),`CFrame.lookAt: expected Vector3 for 1st argument, got {
type(k)}`)assert(isVector3(l),`CFrame.lookAt: expected Vector3 for 2nd argument, got {
type(l)}`)m=(m and assert(isVector3(m),`CFrame.lookAt: expected Vector3 for 3rd argument, got {
type(m)}`)and m)or b.yAxis local n=(l-k).unit if n.magnitude==0 then return
constructor(k.x,k.y,k.z)end local o=m:cross(n).unit if o.magnitude==0 then local
p=c(n.y)<0.999 and b.yAxis or b.xAxis o=p:cross(n).unit end local p=n:cross(o).
unit local q=(o:cross(p))q=n*-1 return constructor(k.x,k.y,k.z,o.x,p.x,q.x,o.y,p
.y,q.y,o.z,p.z,q.z)end function j.lookAlong(k,l,m)assert(isVector3(k),`CFrame.lookAlong: expected Vector3 for 1st argument, got {
type(k)}`)assert(isVector3(l),`CFrame.lookAlong: expected Vector3 for 2nd argument, got {
type(l)}`)return j.lookAt(k,k+l,m)end function j.fromRotationBetweenVectors(k,l)
assert(isVector3(k),`CFrame.fromRotationBetweenVectors: expected Vector3 for 1st argument, got {
type(k)}`)assert(isVector3(l),`CFrame.fromRotationBetweenVectors: expected Vector3 for 2nd argument, got {
type(l)}`)local m=k.unit local n=l.unit if m.magnitude==0 or n.magnitude==0 then
return constructor(0,0,0)end local o=i(m:dot(n),-1,1)if o>0.99999999 then return
constructor(0,0,0)elseif o<-0.99999999 then local p=(c(m.x)<0.9 and b.xAxis or b
.yAxis):cross(m).unit return j.fromAxisAngle(p,math.pi)else local p=m:cross(n).
unit local q=g(o)return j.fromAxisAngle(p,q)end end function j.fromEulerAngles(k
,l,m,n)local o,p,q,r,s,t,u,v,w=columnsFromEuler(k,l,m,n)return constructor(0,0,0
,o,p,q,r,s,t,u,v,w)end function j.fromEulerAnglesXYZ(k,l,m)return j.
fromEulerAngles(k,l,m,'XYZ')end function j.fromEulerAnglesYXZ(k,l,m)return j.
fromEulerAngles(k,l,m,'YXZ')end function j.Angles(k,l,m)return j.
fromEulerAnglesXYZ(k,l,m)end function j.fromOrientation(k,l,m)return j.
fromEulerAnglesYXZ(k,l,m)end function j.fromAxisAngle(k,l)assert(isVector3(k),`CFrame.fromAxisAngle: expected Vector3 for axis, got {
type(k)}`)assert('number'==type(l),`CFrame.fromAxisAngle: expected number for angle, got {
type(l)}`)local m=k.unit local n,o,p=m.x,m.y,m.z local q,r,s=f(l),e(l),1-f(l)
local t=s*n*n+q local u=s*n*o+r*p local v=s*n*p-r*o local w=s*n*o-r*p local x=s*
o*o+q local y=s*o*p+r*n local z=s*n*p+r*o local A=s*o*p-r*n local B=s*p*p+q
return constructor(0,0,0,t,u,v,w,x,y,z,A,B)end function j.fromMatrix(k,l,m,n)
assert(isVector3(k),`CFrame.fromMatrix: expected Vector3 for pos, got {type(k)}`
)assert(isVector3(l),`CFrame.fromMatrix: expected Vector3 for vX, got {type(l)}`
)assert(isVector3(m),`CFrame.fromMatrix: expected Vector3 for vY, got {type(m)}`
)if nil~=n then assert(isVector3(n),`CFrame.fromMatrix: expected Vector3 for vZ, got {
type(n)}`)end local o=l local p=m local q=n or o:cross(p).unit return
constructor(k.x,k.y,k.z,o.x,p.x,q.x,o.y,p.y,q.y,o.z,p.z,q.z)end function j.
inverse(k)local l,m,n,o,p,q,r,s,t=rotTranspose(k)local u=b.new(k.x,k.y,k.z)local
v=b.new(-(l*u.x+m*u.y+n*u.z),-(o*u.x+p*u.y+q*u.z),-(r*u.x+s*u.y+t*u.z))return
constructor(v.x,v.y,v.z,l,m,n,o,p,q,r,s,t)end function j.lerp(k,l,m:number)
assert(isCFrame(l),`CFrame.lerp: expected a CFrame, got {type(l)}`)assert(
'number'==type(m),`CFrame.lerp: expected a number for alpha, got {type(m)}`)
local n=k.x+(l.x-k.x)*m local o=k.y+(l.y-k.y)*m local p=k.z+(l.z-k.z)*m local q,
r,s,t=toQuaternion(k)local u,v,w,x=toQuaternion(l)local y,z,A,B=slerp(q,r,s,t,u,
v,w,x,m)return fromQuaternion(n,o,p,y,z,A,B)end function j.orthonormalize(k)
local l=b.new(k.r00,k.r10,k.r20).unit local m=b.new(k.r01,k.r11,k.r21)m=(m-l*l:
dot(m)).unit local n=l:cross(m)return constructor(k.x,k.y,k.z,l.x,m.x,n.x,l.y,m.
y,n.y,l.z,m.z,n.z)end function j.toworldspace(k,...)local l=table.pack(...)for m
=1,l.n do assert(isCFrame(l[m]),`CFrame.toworldspace: expected CFrame, got {
type(l[m])}`)l[m]=k*l[m]end return table.unpack(l,1,l.n)end function j.
toobjectspace(k,...)local l=k:inverse()local m=table.pack(...)for n=1,m.n do
assert(isCFrame(m[n]),`CFrame.toobjectspace: expected CFrame, got {type(m[n])}`)
m[n]=l*m[n]end return table.unpack(m,1,m.n)end function j.pointtoworldspace(k,
...)local l=table.pack(...)for m=1,l.n do assert(isVector3(l[m]),`CFrame.pointtoworldspace: expected Vector3, got {
type(l[m])}`)local n:any=l[m]l[m]=b.new(k.x,k.y,k.z)+rotateVec(k,n)end return
table.unpack(l,1,l.n)end function j.pointtoobjectspace(k,...)local l=table.pack(
...)for m=1,l.n do assert(isVector3(l[m]),`CFrame.pointtoobjectspace: expected Vector3, got {
type(l[m])}`)local n:any=l[m]local o=n-b.new(k.x,k.y,k.z)l[m]=rotateVecT(k,o)end
return table.unpack(l,1,l.n)end function j.vectortoworldspace(k,...)local l=
table.pack(...)for m=1,l.n do assert(isVector3(l[m]),`CFrame.vectortoworldspace: expected Vector3, got {
type(l[m])}`)l[m]=rotateVec(k,l[m])end return table.unpack(l,1,l.n)end function
j.vectortoobjectspace(k,...)local l=table.pack(...)for m=1,l.n do assert(
isVector3(l[m]),`CFrame.vectortoobjectspace: expected Vector3, got {type(l[m])}`
)l[m]=rotateVecT(k,l[m])end return table.unpack(l,1,l.n)end function j.
getcomponents(k)return k.x,k.y,k.z,k.r00,k.r01,k.r02,k.r10,k.r11,k.r12,k.r20,k.
r21,k.r22 end function j.toeulerangles(k,l)l=string.upper(l or'XYZ')local m,n,o=
k.r00,k.r01,k.r02 local p,q,r=k.r10,k.r11,k.r12 local s,t,u=k.r20,k.r21,k.r22 if
l=='XYZ'then local v=s local w,x,y if c(v)<0.999999 then w=h(-t,u)x=h(v,d(1-v*v)
)y=h(-p,m)else w=h(q,r)x=h(v,d(1-v*v))y=0 end return w,x,y elseif l=='YXZ'then
local v=-t local w,x,y if c(v)<0.999999 then x=h(s,u)w=h(v,d(1-v*v))y=h(n,q)else
x=h(-o,m)w=h(v,d(1-v*v))y=0 end return w,x,y else return j.fromEulerAnglesXYZ(0,
0,0):toeulerangles'XYZ'end end function j.toeuleranglesxyz(k)return k:
toeulerangles'XYZ'end function j.toeuleranglesyxz(k)return k:toeulerangles'YXZ'
end function j.toorientation(k)return k:toeulerangles'YXZ'end function j.
toaxisangle(k)local l,m,n,o=toQuaternion(k)local p=2*g(i(o,-1,1))local q=d(1-o*o
)if q<1e-6 then return b.xAxis,0 end return b.new(l/q,m/q,n/q),p end function j.
fuzzyeq(k,l,m:number?)assert(isCFrame(l),`CFrame.fuzzyeq: expected a CFrame, got {
type(l)}`)assert('number'==type(m)or'nil'==type(m),`CFrame.fuzzyeq: expected a number for epsilon, got {
type(m)}`)m=m or 1e-5 if c(k.x-l.x)>m or c(k.y-l.y)>m or c(k.z-l.z)>m then
return false end return k:anglebetween(l)<=m end function j.anglebetween(k,l)
assert(isCFrame(l),`CFrame.anglebetween: expected a CFrame, got {type(l)}`)local
m,n,o,p,q,r,s,t,u=matMul({r00=k.r00,r01=k.r01,r02=k.r02,r10=k.r10,r11=k.r11,r12=
k.r12,r20=k.r20,r21=k.r21,r22=k.r22},{r00=l.r00,r01=l.r01,r02=l.r02,r10=l.r10,
r11=l.r11,r12=l.r12,r20=l.r20,r21=l.r21,r22=l.r22})return g(i((m+q+u-1)*0.5,-1,1
))end j.identity=constructor(0,0,0)j.__metatable='CFrame'function j.__mul(k,l)if
isVector3(l)then local m=l::any return b.new(k.x+k.r00*m.x+k.r01*m.y+k.r02*m.z,k
.y+k.r10*m.x+k.r11*m.y+k.r12*m.z,k.z+k.r20*m.x+k.r21*m.y+k.r22*m.z)end assert(
isCFrame(l),`CFrame.__mul: expected CFrame or Vector3, got {type(l)}`)local m,n,
o,p,q,r,s,t,u=matMul(k,l)local v=b.new(k.x+k.r00*l.x+k.r01*l.y+k.r02*l.z,k.y+k.
r10*l.x+k.r11*l.y+k.r12*l.z,k.z+k.r20*l.x+k.r21*l.y+k.r22*l.z)return
constructor(v.x,v.y,v.z,m,n,o,p,q,r,s,t,u)end function j.__add(k,l)assert(
isVector3(l),`CFrame.__add: expected a Vector3, got {type(l)}`)return
constructor(k.x+l.x,k.y+l.y,k.z+l.z,k.r00,k.r01,k.r02,k.r10,k.r11,k.r12,k.r20,k.
r21,k.r22)end function j.__sub(k,l)assert(isVector3(l),`CFrame.__sub: expected a Vector3, got {
type(l)}`)return constructor(k.x-l.x,k.y-l.y,k.z-l.z,k.r00,k.r01,k.r02,k.r10,k.
r11,k.r12,k.r20,k.r21,k.r22)end function j.__index(k,l)l=string.lower(l)if
'position'==l then return b.new(k.x,k.y,k.z)end if'rotation'==l then return
constructor(0,0,0,k.r00,k.r01,k.r02,k.r10,k.r11,k.r12,k.r20,k.r21,k.r22)end if
'x'==l then return k.x end if'y'==l then return k.y end if'z'==l then return k.z
end if'xvector'==l or'rightvector'==l then return b.new(k.r00,k.r10,k.r20)end if
'yvector'==l or'upvector'==l then return b.new(k.r01,k.r11,k.r21)end if'zvector'
==l then return b.new(k.r02,k.r12,k.r22)end if'lookvector'==l then return b.new(
k.r02,k.r12,k.r22)*-1 end return rawget(j,l)or k[l]end function j.__tostring(k)
return`({k.x}, {k.y}, {k.z}, {k.r00}, {k.r01}, {k.r02}, {k.r10}, {k.r11}, {k.r12
}, {k.r20}, {k.r21}, {k.r22})`end end return table.freeze(j)end function a.k()
return function(b,c):any if not b then return c end if not c then return b end
for d,e in c do b[d]=e end return b end end function a.l()local b=a.load'k'local
c={}do local d={global={}}local function constructor(e:any)e='userdata'==type(e)
and e or'table'==type(e)and rawget(e,'Data')assert('userdata'==type(e),`Instance.new: userdata must be a userdata, got {
type(e)}`)return setmetatable({ClassName=getclassname(e),Data=e},{__index=c.
__index,__newindex=c.__newindex})end c.new=constructor function c.declare<T>(e:
'property'|'method',f:string|{string},g:string,h:T|((self:typeof(c))->any))
assert('string'==type(g),`Instance.declare: name must be a string, got {type(g)}`
)assert('property'==e or'method'==e,`Instance.declare: value must be "property" or "method", got {
e}`)assert('table'==type(f)or'string'==type(f),`Instance.declare: class must be a string or a table of strings, got {
type(f)}`)if'string'==type(f)then d[f]=b(d[f],{[g]={[e]=h}})else for i,j in f do
d[j]=b(d[j],{[g]={[e]=h}})end end end function c.__index(e,f:string)assert(
'string'==type(f),`Instance:__index: key must be a string, got {type(f)}`)do
local g=e.ClassName local h=d.global[f]or(d[g]and d[g][f])if h then local i=h.
property local j=h.method if i and i.getter then return i.getter(e)elseif j then
return j end end end return rawget(e,f)or rawget(e,'Data')and e:FindFirstChild(f
)or c[f]end function c.__newindex(e,f:string,g:any)assert('string'==type(f),`Instance:__newindex: key must be a string, got {
type(f)}`)do local h=e.ClassName local i=d.global[f]or(d[h]and d[h][f])if i and
i.property and i.property.setter then return i.property.setter(e,g)end end
return rawset(e,f,g)end end return c end function a.m()local b=a.load'i'local c=
a.load'f'local d=a.load'h'local e=a.load'g'local f=a.load'e'local g=a.load'd'
local h=a.load'j'local i do d.get({
[[https://raw.githubusercontent.com/MaximumADHD/Roblox-Client-Tracker/refs/heads/roblox/Full-API-Dump.json]]
,'application/json'},function(j)i=e.decode(j)end)end local j=a.load'l'do local k
=j.new do j.declare('property','global','Name',{getter=function(l)return
getname(l.Data)end})j.declare('property','global','Parent',{getter=function(l)
local m:any=getparent(l.Data)return m and k(m)end})j.declare('method','global',
'GetChildren',function(l)return b(getchildren(l.Data),k)end)j.declare('method',
'global','GetDescendants',function(l)return b(getdescendants(l.Data),k)end)do
local l=function(l)return function(m,...)local n:any=l(m.Data,...)return n and
k(n)end end j.declare('method','global','FindFirstChild',l(findfirstchild))j.
declare('method','global','FindFirstAncestor',l(findfirstancestor))j.declare(
'method','global','FindFirstChildOfClass',l(findfirstchildofclass))j.declare(
'method','global','FindFirstAncestorOfClass',l(findfirstancestorofclass))j.
declare('method','global','WaitForChild',l(waitforchild))end do local l=function
(l)return function(m,...)return l(m.Data,...)end end j.declare('method','global'
,'SetMemoryValue',l(c.write))j.declare('method','global','GetMemoryValue',l(c.
read))j.declare('method','global','Read',l(c.read))j.declare('method','global',
'Write',l(c.write))end j.declare('method','global','IsA',function(l,m:string)
assert('string'==type(m),`Instance:IsA: class must be a string, got {type(m)}`)
return l.ClassName==m end)j.declare('method','global','IsAncestorOf',function(l,
m)assert('userdata'==type(m)or type(m)=='table'and m.Data,`Instance:IsAncestorOf: other must be a userdata or an Instance, got {
type(m)}`)return isancestorof(l.Data,type(m)=='userdata'and m or m.Data)end)j.
declare('method','global','IsDescendantOf',function(l,m)assert('userdata'==type(
m)or type(m)=='table'and m.Data,`Instance:IsDescendantOf: other must be a userdata or an Instance, got {
type(m)}`)return isdescendantof(l.Data,type(m)=='userdata'and m or m.Data)end)j.
declare('method','global','Destroy',function(l)return destroy(l.Data)end)end do
j.declare('property','DataModel','PlaceId',{getter=function(l)return getplaceid(
)end})j.declare('property','DataModel','GameId',{getter=function(l)return
getgameid()end})j.declare('method','DataModel','GetService',function(l,m:string)
for n,o in getchildren(l.Data)do if getclassname(o)==m then return k(o)end end
return nil end)j.declare('method','DataModel','FindService',function(l,m:string)
local n:any=findservice(l.Data,m)return n and k(n)end)j.declare('method',
'DataModel','HttpGet',function(l,m:string,...)assert('string'==type(m),`DataModel:HttpGet: url must be a string, got {
type(m)}`)return httpget(m,...)end)j.declare('method','DataModel','HttpPost',
function(l,m:string,...)assert('string'==type(m),`DataModel:HttpPost: url must be a string, got {
type(m)}`)return httppost(m,...)end)end do j.declare('method','HttpService',
'JSONEncode',function(l,m:any)assert('table'==type(m),`HttpService:JSONEncode: value must be a table, got {
type(m)}`)return e.encode(m)end)j.declare('method','HttpService','JSONDecode',
function(l,m:string)assert('string'==type(m),`HttpService:JSONDecode: value must be a string, got {
type(m)}`)return e.decode(m)end)end do j.declare('property',{'BoolValue',
'IntValue','FloatValue','ObjectValue','StringValue','Vector3Value','ValueBase',
'BrickColorValue','Color3Value','CFrameValue','DoubleConstrainedValue',
'IntConstrainedValue'},'Value',{getter=function(l)return getvalue(l.Data)end,
setter=function(l,m:any)setvalue(l.Data,m)end})end do j.declare('property',{
'UnionOperation','MeshPart','TrussPart','Part'},'Size',{getter=function(l)local
m=getsize(l.Data)return f.new(m.x,m.y,m.z)end})j.declare('property',{
'UnionOperation','MeshPart','TrussPart','Part','Camera'},'Position',{getter=
function(l)local m=getposition(l.Data)return f.new(m.x,m.y,m.z)end,setter=
function(l,m:vector|{x:number,y:number,z:number})assert('table'==type(m)and m.x
and m.y and m.z,`Instance:Position: value must be a Vector3, got {type(m)}`)
setposition(l.Data,m)end})j.declare('property',{'UnionOperation','MeshPart',
'TrussPart','Part','Camera'},'CFrame',{getter=function(l)local m=getposition(l.
Data)local n=getupvector(l.Data)local o=getrightvector(l.Data)local p=
getlookvector(l.Data)return h.new(tonumber(m.x),tonumber(m.y),tonumber(m.z),
tonumber(o.x),tonumber(n.x),-tonumber(p.x)::number,tonumber(o.y),tonumber(n.y),-
tonumber(p.y)::number,tonumber(o.z),tonumber(n.z),-tonumber(p.z)::number)end,
setter=function(l,m:any)setcframe(l.Data,m)end})j.declare('property',{
'UnionOperation','MeshPart','TrussPart','Part'},'Rotation',{getter=function(l)
local m=getupvector(l.Data)local n=getrightvector(l.Data)local o=getlookvector(l
.Data)local p=h.fromMatrix(f.zero,f.new(n.x,n.y,n.z),f.new(m.x,m.y,m.z),-f.new(o
.x,o.y,o.z))local q,r,s=p:ToEulerAnglesXYZ()return f.new(math.deg(q),math.deg(r)
,math.deg(s))end,setter=function(l,m:any)assert(type(m)=='table'and
getmetatable(m)=='Vector3',`Instance.Rotation: value must be a Vector3`)local n=
math.rad(m.x)local o=math.rad(m.y)local p=math.rad(m.z)local q=h.
fromEulerAnglesXYZ(n,o,p)local r=f.new(q.r00,q.r10,q.r20)local s=f.new(q.r01,q.
r11,q.r21)local t=f.new(-q.r02,-q.r12,-q.r22)setrightvector(l.Data,r)
setupvector(l.Data,s)setlookvector(l.Data,t)end})j.declare('property',{
'UnionOperation','MeshPart','TrussPart','Part'},'Transparency',{getter=function(
l)return gettransparency(l.Data)end,setter=function(l,m:number)settransparency(l
.Data,m)end})end do j.declare('property','Player','Character',{getter=function(l
)return k(getcharacter(l.Data))end})j.declare('property','Player','Team',{getter
=function(l)return k(getteam(l.Data))end})j.declare('property','Player',
'DisplayName',{getter=function(l)return getdisplayname(l.Data)end})j.declare(
'property','Player','UserId',{getter=function(l)return getuserid(l.Data)end})end
do j.declare('property','Workspace','CurrentCamera',{getter=function(l)local m:
any=findfirstchildofclass(l.Data,'Camera')return m and k(m)end})end do j.
declare('property','Camera','FieldOfView',{getter=function(l)return
getcamerafov(l.Data)end})j.declare('method','Camera','SetCameraSubject',function
(l,m)assert(type(m)=='table'and m.Data,`Camera:SetCameraSubject: subject must be an Instance, got {
type(m)}`)return setcamerasubject(m.Data)end)end do j.declare('property',{
'UnionOperation','MeshPart','TrussPart','Part'},'CanCollide',{getter=function(l)
return getcancollide(l.Data)end,setter=function(l,m:boolean)assert(type(m)==
'boolean',`Instance:CanCollide: value must be a boolean, got {type(m)}`)
setcancollide(l.Data,m)end})j.declare('property',{'UnionOperation','MeshPart',
'TrussPart','Part'},'Velocity',{getter=function(l)local m=getvelocity(l.Data)
return f.new(m.x,m.y,m.z)end,setter=function(l,m:vector|{x:number,y:number,z:
number})assert('table'==type(m)and m.x and m.y and m.z,`Instance:Velocity: value must be a Vector3, got {
type(m)}`)setvelocity(l.Data,m)end})end do j.declare('property','MeshPart',
'TextureID',{getter=function(l)return gettextureid(l.Data)end})j.declare(
'property','MeshPart','MeshID',{getter=function(l)return getmeshid(l.Data)end})
end do j.declare('property','Humanoid','Health',{getter=function(l)return
gethealth(l.Data)end})j.declare('property','Humanoid','MaxHealth',{getter=
function(l)return getmaxhealth(l.Data)end})end do j.declare('property','Model',
'PrimaryPart',{getter=function(l)local m:any=getprimarypart(l.Data)return m and
k(m)end})end do j.declare('property','BillboardGui','Adornee',{getter=function(l
)local m:any=getadornee(l.Data)return m and k(m)end})end do j.declare('property'
,'Players','LocalPlayer',{getter=function(l)local m:any=getlocalplayer()return m
and k(m)end})end do j.declare('method','MouseService','GetMousePosition',
function(l)local m=getmouseposition()return g.new(m.x,m.y)end)j.declare('method'
,'MouseService','GetMouseLocation',function(l)local m=getmouselocation(l.Data)
return g.new(m.x,m.y)end)j.declare('method','MouseService','GetMouseBehavior',
function(l)return getmousebehavior(l.Data)end)j.declare('method','MouseService',
'GetMouseDeltaSensitivity',function(l)return getmousedeltasensitivity(l.Data)end
)j.declare('method','MouseService','IsMouseIconEnabled',function(l)return
ismouseiconenabled(l.Data)end)j.declare('method','MouseService',
'SetMouseLocation',function(l,m,n)assert('number'==type(m),`MouseService:SetMouseLocation: x must be a number, got {
type(m)}`)assert('number'==type(n),`MouseService:SetMouseLocation: y must be a number, got {
type(n)}`)setmouselocation(l.Data,m,n)end)j.declare('method','MouseService',
'SetMouseIconEnabled',function(l,m)assert('boolean'==type(m),`MouseService:SetMouseIconEnabled: enabled must be a boolean, got {
type(m)}`)setmouseiconenabled(l.Data,m)end)j.declare('method','MouseService',
'SetMouseBehavior',function(l,m)assert('number'==type(m),`MouseService:SetMouseBehavior: behavior must be a number, got {
type(m)}`)setmousebehaviour(l.Data,m)end)j.declare('method','MouseService',
'SetMouseDeltaSensitivity',function(l,m)assert('number'==type(m),`MouseService:SetMouseDeltaSensitivity: sensitivity must be a number, got {
type(m)}`)setmousedeltasensitivity(l.Data,m)end)j.declare('method',
'MouseService','SmoothMouseExponential',function(l,m,n,o)assert('table'==type(m)
and#m>=2,`MouseService:SmoothMouseExponential: origin must be a table with at least 2 numbers, got {
type(m)}`)assert('table'==type(n)and#n>=2,`MouseService:SmoothMouseExponential: point must be a table with at least 2 numbers, got {
type(n)}`)assert('number'==type(o),`MouseService:SmoothMouseExponential: speed must be a number, got {
type(o)}`)local p=smoothmouse_exponential(m,n,o)return g.new(p.x,p.y)end)j.
declare('method','MouseService','SmoothMouseLinear',function(l,m,n,o,p)assert(
'table'==type(m)and#m>=2,`MouseService:SmoothMouseLinear: origin must be a table with at least 2 numbers, got {
type(m)}`)assert('table'==type(n)and#n>=2,`MouseService:SmoothMouseLinear: point must be a table with at least 2 numbers, got {
type(n)}`)assert('number'==type(o),`MouseService:SmoothMouseLinear: sensitivity must be a number, got {
type(o)}`)assert('number'==type(p),`MouseService:SmoothMouseLinear: smoothness must be a number, got {
type(p)}`)local q=smoothmouse_linear(m,n,o,p)return g.new(q.x,q.y)end)end end _G
.Instance=j _G.Vector3=f _G.Vector2=g _G.CFrame=h _G.workspace=j.new(Workspace)
_G.game=j.new(Game)return j end end _G.Signal=a.load'a'_G.websocket=a.load'b'_G.
memory=a.load'f'_G.json=a.load'g'_G.http=a.load'h'_G.print=function(...)local b,
c={...},select('#',...)local d=''for e=1,c do local f=b[e]if type(f)=='table'
then if f.Name and f.Data then d=d..f.Name..' | 'end elseif type(f)=='userdata'
then d=d..getname(f)..' | 'end local g=tostring(f)if type(g)~='string'then error
"'tostring' must return a string - print function"end d=d..g..' 'end return
print(d)end _G.warn=function(...)local b,c={...},select('#',...)local d=''for e=
1,c do local f=b[e]if type(f)=='table'then if f.Name and f.Data then d=d..f.Name
..' | 'end elseif type(f)=='userdata'then d=d..getname(f)..' | 'end local g=
tostring(f)if type(g)~='string'then error
"'tostring' must return a string - warn function"end d=d..g..' 'end return warn(
d)end return a.load'm'