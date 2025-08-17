type connection__DARKLUA_TYPE_a={unbind:()->()}local a a={cache={},load=function
(b)if not a.cache[b]then a.cache[b]={c=a[b]()}end return a.cache[b].c end}do
function a.a()local b={}do function b.connect(c:string)local d=
websocket_connect(c)local e={}do local f={}function e.send(g,h:string)assert(
'string'==type(h),`websocket:send: message must be a string, got {type(h)}`)
websocket_send(d,h)end function e.on(g,h:string,i)assert('string'==type(h),`websocket:on: event must be a string, got {
type(h)}`)assert('function'==type(i),`websocket:on: callback must be a function, got {
type(i)}`)f[h]=f[h]or{}table.insert(f[h],i)return{disconnect=function()assert(
'function'==type(i),`connection:disconnect: callback must be a function, got {
type(i)}`)local j=table.find(f[h],i)if j then table.remove(f[h],j)end end}end
function e.close(g)websocket_close(d)end end return e end end return b end
function a.b()local b={}do local function constructor()return setmetatable({_map
={}},{__index=b})end b.new=constructor function b.emit<T...>(c,...:T...)for d=#c
,1,-1 do local e=c[d]if e then if'function'==type(e)then coroutine.wrap(e)(...)
elseif'thread'==type(e)then coroutine.resume(e,...)end end end return c end
function b.bind<T...>(c,d:(T...)->()):connection__DARKLUA_TYPE_a table.insert(c,
d)return{unbind=function()local e=table.find(c,d)if e then table.remove(c,e)end
end}end function b.once<T...>(c,d:(T...)->()):connection__DARKLUA_TYPE_a local e
do e=c:bind(function(...)d(...)e:unbind()end)end return e end function b.wait<T
...>(c):T...local d=coroutine.running()c:once(function(...)coroutine.resume(d,
...)end)return coroutine.yield()end setmetatable(b,{__call=constructor})end
return b end function a.c()return function(b,c)assert('table'==type(b),`map(t, callback): expected a table, got {
type(b)}`)assert('function'==type(c),`map(t, callback): expected a function, got {
type(c)}`)local d={}do for e,f in b do d[e]=c(f,e,b)end end return d end end
function a.d()local b={}local c={__index=b}function c.__add(d,e)return b.new(d.x
+e.x,d.y+e.y,d.z+e.z)end function c.__sub(d,e)return b.new(d.x-e.x,d.y-e.y,d.z-e
.z)end function c.__unm(d)return b.new(-d.x,-d.y,-d.z)end function c.__eq(d,e)if
d.x==e.x and d.y==e.y and d.z==e.z then return true else return false end end
function c.__tostring(d)return'('..d.x..', '..d.y..', '..d.z..')'end function c.
__concat(d,e)return tostring(d)..tostring(e)end function c.__mul(d,e)if type(e)
=='number'then return b.new(d.x*e,d.y*e,d.z*e)end return b.new(d.x*e.x,d.y*e.y,d
.z*e.z)end function c.__div(d,e)if type(e)=='number'then if e==0 then print
'Attempted to divide by zero. Returning nil'return nil end return b.new(d.x/e,d.
y/e,d.z/e)end if e.x==0 or e.y==0 or e.z==0 then print
'Attempted to divide by zero. Returning nil.'return nil end return b.new(d.x/e.x
,d.y/e.y,d.z/e.z)end function b.new(d,e,f)return setmetatable({x=d or 0,y=e or 0
,z=f or 0},c)end function b.lerp(d,e,f)return b.new(d.x+(e.x-d.x)*f,d.y+(e.y-d.y
)*f,d.z+(e.z-d.z)*f)end function b.distance(d,e)return math.sqrt((d.x-e.x)^2+(d.
y-e.y)^2+(d.z-e.z)^2)end function b.magnitude(d)return math.sqrt(d.x^2+d.y^2+d.z
^2)end function b.normalized(d)local e=d:magnitude()if e==0 then return b.new()
end return b.new(d.x/e,d.y/e,d.z/e)end function b.dot(d,e)return((d.x*e.x)+(d.y*
e.y)+(d.z*e.z))end function b.cross(d,e)local f=b.new((d.y*e.z)-(d.z*e.y),(d.z*e
.x)-(d.x*e.z),(d.x*e.y)-(d.y*e.x))if f.x==0 then f.x=0 end if f.y==0 then f.y=0
end if f.z==0 then f.z=0 end return f end function b.tostring(d)return tostring(
d)end b.zero=b.new(0,0,0)b.up=b.new(0,1,0)b.down=b.new(0,-1,0)b.left=b.new(-1,0,
0)b.right=b.new(1,0,0)b.forward=b.new(0,0,1)b.back=b.new(0,0,-1)return b end
function a.e()local b={}local c=math.sqrt function b.new(d,e)assert(tonumber(d)
or(d==nil),'Vector2 coordinates can only be numbers')assert(tonumber(d)or(d==nil
),'Vector2 coordinates can only be numbers')local f={}setmetatable(f,b)f.x=d or
0 f.y=e or 0 f.Type='Vector2'return f end function b.__index(d,e)if e==
'magnitude'then local f,g=rawget(d,'x'),rawget(d,'y')return c(f*f+g*g)elseif e==
'unit'then local f,g=rawget(d,'x'),rawget(d,'y')local h=c(f*f+g*g)if h==0 then
return d end return b.new(f/h,g/h)end return rawget(b,e)end function b.
__tostring(d)return d.x..', '..d.y end function b.__eq(d,e)assert(e.Type==
'Vector2','Cannot compare Vector2 with '..tostring(e))if d.x==e.x and d.y==e.y
then return true end return false end function b.__add(d,e)if type(e)=='number'
then return b.new(d.x+e,d.y+e)end return b.new(d.x+e.x,d.y+e.y)end function b.
__mul(d,e)if type(e)=='number'then return b.new(d.x*e,d.y*e)end return b.new(d.x
*e.x,d.y*e.y)end function b.__div(d,e)if type(e)=='number'then return b.new(d.x/
e,d.y/e)end return b.new(d.x/e.x,d.y/e.y)end function b.__sub(d,e)if type(e)==
'number'then return b.new(d.x-e,d.y-e)end return b.new(d.x-e.x,d.y-e.y)end
return b end function a.f()local b={}do local function constructor(c:number,d:
number,e:number)assert('number'==type(c),`Color3.new: red must be a number, got {
type(c)}`)assert('number'==type(d),`Color3.new: green must be a number, got {
type(d)}`)assert('number'==type(e),`Color3.new: blue must be a number, got {
type(e)}`)return setmetatable({c,d,e},{__index=b.__index,__tostring=b.__tostring
})end function b.toHSV(c)local d,e,f=c[1]/255,c[2]/255,c[3]/255 local g,h=math.
max(d,e,f),math.min(d,e,f)local i,j,k k=g local l=g-h if g~=0 then j=l/g else j=
0 i=0 return i,j,k end if d==g then i=(e-f)/l elseif e==g then i=2+(f-d)/l else
i=4+(d-e)/l end i=i*60 if i<0 then i=i+360 end return i,j,k end function b.toHex
(c)local d=string.format('%02X',math.floor(c[1]))local e=string.format('%02X',
math.floor(c[2]))local f=string.format('%02X',math.floor(c[3]))return`{d}{e}{f}`
end function b.fromRGB(c:number,d:number,e:number):Color3 assert('number'==type(
c),`Color3.fromRGB: red must be a number, got {type(c)}`)assert('number'==type(d
),`Color3.fromRGB: green must be a number, got {type(d)}`)assert('number'==type(
e),`Color3.fromRGB: blue must be a number, got {type(e)}`)return constructor(c,d
,e)end do local c=b.fromRGB function b.fromHex(d:string)assert('string'==type(d)
,`Color3.fromHex: data must be a string, got {type(d)}`)local e=tonumber(d:sub(1
,2),16)local f=tonumber(d:sub(3,4),16)local g=tonumber(d:sub(5,6),16)return c(e,
f,g)end function b.fromHSV(d,e,f)assert(type(d)=='number'and type(e)=='number'
and type(f)=='number','HSV values must be numbers')d=math.clamp(d,0,360)e=math.
clamp(e,0,1)f=math.clamp(f,0,1)local g=f*e local h=g*(1-math.abs((d/60)%2-1))
local i=f-g local j,k,l if d<60 then j,k,l=g,h,0 elseif d<120 then j,k,l=h,g,0
elseif d<180 then j,k,l=0,g,h elseif d<240 then j,k,l=0,h,g elseif d<300 then j,
k,l=h,0,g else j,k,l=g,0,h end return c(math.floor((j+i)*255),math.floor((k+i)*
255),math.floor((l+i)*255))end end function b.buffer(c:buffer|typeof(b))assert(
'buffer'==type(c)or'table'==type(c),`Color3.buffer: value must be a buffer or Color3, got {
type(c)}`)if'buffer'==type(c)then local d=buffer.readi8(c,0)local e=buffer.
readi8(c,1)local f=buffer.readi16(c,2)return b.fromRGB(d,e,f)else local d=buffer
.create(8)buffer.writei8(d,0,c[1])buffer.writei8(d,1,c[2])buffer.writei16(d,2,c[
3])return d end end function b.dword(c:number|typeof(b))assert('number'==type(c)
or'table'==type(c),`Color3.dword: value must be a number or Color3, got {type(c)
}`)if'number'==type(c)then return b.fromRGB(bit32.band(c,0xff),bit32.band(bit32.
rshift(c,8),0xff),bit32.band(bit32.rshift(c,16),0xff))else return bit32.bor(c[1]
,bit32.lshift(c[2],8),bit32.lshift(c[3],16))end end function b.__index(c,d:
string)if d:lower()=='r'then return c[1]elseif d:lower()=='g'then return c[2]
elseif d:lower()=='b'then return c[3]end return rawget(c,d)or b[d]end function b
.__eq(c,d)return c[1]==d[1]and c[2]==d[2]and c[3]==d[3]end function b.__tostring
(c)return`Color.new({c[1]}, {c[2]}, {c[3]})`end end local c={Palette={[1032]={
Name='Hot pink',Color=b.fromRGB(255,0,191)},[1031]={Name='Royal purple',Color=b.
fromRGB(98,37,209)},[1030]={Name='Pastel brown',Color=b.fromRGB(255,204,153)},[
1029]={Name='Pastel yellow',Color=b.fromRGB(255,255,204)},[1028]={Name=
'Pastel green',Color=b.fromRGB(204,255,204)},[1027]={Name='Pastel blue-green',
Color=b.fromRGB(159,243,233)},[1026]={Name='Pastel violet',Color=b.fromRGB(177,
167,255)},[1025]={Name='Pastel orange',Color=b.fromRGB(255,201,201)},[1024]={
Name='Pastel light blue',Color=b.fromRGB(175,221,255)},[1023]={Name='Lavender',
Color=b.fromRGB(140,91,159)},[1022]={Name='Grime',Color=b.fromRGB(127,142,100)},
[1021]={Name='Camo',Color=b.fromRGB(58,125,21)},[1020]={Name='Lime green',Color=
b.fromRGB(0,255,0)},[1019]={Name='Toothpaste',Color=b.fromRGB(0,255,255)},[1018]
={Name='Teal',Color=b.fromRGB(18,238,212)},[1017]={Name='Deep orange',Color=b.
fromRGB(255,175,0)},[1016]={Name='Pink',Color=b.fromRGB(255,102,204)},[1015]={
Name='Magenta',Color=b.fromRGB(170,0,170)},[1014]={Name='CGA brown',Color=b.
fromRGB(170,85,0)},[1013]={Name='Cyan',Color=b.fromRGB(4,175,236)},[1012]={Name=
'Deep blue',Color=b.fromRGB(33,84,185)},[1011]={Name='Navy blue',Color=b.
fromRGB(0,32,96)},[1010]={Name='Really blue',Color=b.fromRGB(0,0,255)},[1009]={
Name='New Yeller',Color=b.fromRGB(255,255,0)},[1008]={Name='Olive',Color=b.
fromRGB(193,190,66)},[1007]={Name='Dusty Rose',Color=b.fromRGB(163,75,75)},[1006
]={Name='Alder',Color=b.fromRGB(180,128,255)},[1005]={Name='Deep orange',Color=b
.fromRGB(255,176,0)},[1004]={Name='Really red',Color=b.fromRGB(255,0,0)},[1003]=
{Name='Really black',Color=b.fromRGB(17,17,17)},[1002]={Name='Mid gray',Color=b.
fromRGB(205,205,205)},[1001]={Name='Institutional white',Color=b.fromRGB(248,248
,248)},[365]={Name='Burnt Sienna',Color=b.fromRGB(106,57,9)},[364]={Name=
'Dark taupe',Color=b.fromRGB(90,76,66)},[363]={Name='Flint',Color=b.fromRGB(105,
102,92)},[362]={Name='Bronze',Color=b.fromRGB(126,104,63)},[361]={Name=
'Medium brown',Color=b.fromRGB(86,66,54)},[360]={Name='Copper',Color=b.fromRGB(
150,103,102)},[359]={Name='Linen',Color=b.fromRGB(175,148,131)},[358]={Name=
'Cloudy grey',Color=b.fromRGB(171,168,158)},[357]={Name='Hurricane grey',Color=b
.fromRGB(149,137,136)},[356]={Name='Fawn brown',Color=b.fromRGB(160,132,79)},[
355]={Name='Pine Cone',Color=b.fromRGB(108,88,75)},[354]={Name='Oyster',Color=b.
fromRGB(187,179,178)},[353]={Name='Beige',Color=b.fromRGB(202,191,163)},[352]={
Name='Burlap',Color=b.fromRGB(199,172,120)},[351]={Name='Cork',Color=b.fromRGB(
188,155,93)},[350]={Name='Burgundy',Color=b.fromRGB(136,62,62)},[349]={Name=
'Seashell',Color=b.fromRGB(233,218,218)},[348]={Name='Lily white',Color=b.
fromRGB(237,234,234)},[347]={Name='Khaki',Color=b.fromRGB(226,220,188)},[346]={
Name='Cashmere',Color=b.fromRGB(211,190,150)},[345]={Name='Rust',Color=b.
fromRGB(143,76,42)},[344]={Name='Tawny',Color=b.fromRGB(150,85,85)},[343]={Name=
'Sunrise',Color=b.fromRGB(212,144,189)},[342]={Name='Mauve',Color=b.fromRGB(224,
178,208)},[341]={Name='Buttermilk',Color=b.fromRGB(254,243,187)},[340]={Name=
'Wheat',Color=b.fromRGB(241,231,199)},[339]={Name='Cocoa',Color=b.fromRGB(86,36,
36)},[338]={Name='Terra Cotta',Color=b.fromRGB(190,104,98)},[337]={Name='Salmon'
,Color=b.fromRGB(255,148,148)},[336]={Name='Fog',Color=b.fromRGB(199,212,228)},[
335]={Name='Pearl',Color=b.fromRGB(231,231,236)},[334]={Name='Daisy orange',
Color=b.fromRGB(248,217,109)},[333]={Name='Gold',Color=b.fromRGB(239,184,56)},[
332]={Name='Maroon',Color=b.fromRGB(117,0,0)},[331]={Name='Persimmon',Color=b.
fromRGB(255,89,89)},[330]={Name='Carnation pink',Color=b.fromRGB(255,152,220)},[
329]={Name='Baby blue',Color=b.fromRGB(152,194,219)},[328]={Name='Mint',Color=b.
fromRGB(177,229,166)},[327]={Name='Crimson',Color=b.fromRGB(151,0,0)},[325]={
Name='Quill grey',Color=b.fromRGB(223,223,222)},[324]={Name='Laurel green',Color
=b.fromRGB(168,189,153)},[323]={Name='Olivine',Color=b.fromRGB(148,190,129)},[
322]={Name='Plum',Color=b.fromRGB(123,47,123)},[321]={Name='Lilac',Color=b.
fromRGB(167,94,155)},[320]={Name='Ghost grey',Color=b.fromRGB(202,203,209)},[319
]={Name='Sage green',Color=b.fromRGB(185,196,177)},[318]={Name='Artichoke',Color
=b.fromRGB(138,171,133)},[317]={Name='Moss',Color=b.fromRGB(124,156,107)},[316]=
{Name='Eggplant',Color=b.fromRGB(123,0,123)},[315]={Name='Electric blue',Color=b
.fromRGB(9,137,207)},[314]={Name='Cadet blue',Color=b.fromRGB(159,173,192)},[313
]={Name='Forest green',Color=b.fromRGB(31,128,29)},[312]={Name='Mulberry',Color=
b.fromRGB(89,34,89)},[311]={Name='Fossil',Color=b.fromRGB(159,161,172)},[310]={
Name='Shamrock',Color=b.fromRGB(91,154,76)},[309]={Name='Sea green',Color=b.
fromRGB(52,142,64)},[308]={Name='Dark indigo',Color=b.fromRGB(61,21,133)},[307]=
{Name='Lapis',Color=b.fromRGB(16,42,220)},[306]={Name='Storm blue',Color=b.
fromRGB(51,88,130)},[305]={Name='Steel blue',Color=b.fromRGB(82,124,174)},[304]=
{Name='Parsley green',Color=b.fromRGB(44,101,29)},[303]={Name='Dark blue',Color=
b.fromRGB(0,16,176)},[302]={Name='Smoky grey',Color=b.fromRGB(91,93,105)},[301]=
{Name='Slime green',Color=b.fromRGB(80,109,84)},[268]={Name='Medium lilac',Color
=b.fromRGB(52,43,117)},[232]={Name='Dove blue',Color=b.fromRGB(125,187,221)},[
226]={Name='Cool yellow',Color=b.fromRGB(253,234,141)},[225]={Name=
'Warm yellowish orange',Color=b.fromRGB(235,184,127)},[224]={Name=
'Light brick yellow',Color=b.fromRGB(240,213,160)},[223]={Name='Light pink',
Color=b.fromRGB(220,144,149)},[222]={Name='Light purple',Color=b.fromRGB(228,173
,200)},[221]={Name='Bright purple',Color=b.fromRGB(205,98,152)},[220]={Name=
'Light lilac',Color=b.fromRGB(167,169,206)},[219]={Name='Lilac',Color=b.fromRGB(
107,98,155)},[218]={Name='Reddish lilac',Color=b.fromRGB(150,112,159)},[217]={
Name='Brown',Color=b.fromRGB(124,92,70)},[216]={Name='Rust',Color=b.fromRGB(144,
76,42)},[213]={Name='Medium Royal blue',Color=b.fromRGB(108,129,183)},[212]={
Name='Light Royal blue',Color=b.fromRGB(159,195,233)},[211]={Name='Turquoise',
Color=b.fromRGB(121,181,181)},[210]={Name='Faded green',Color=b.fromRGB(112,149,
120)},[209]={Name='Dark Curry',Color=b.fromRGB(176,142,68)},[208]={Name=
'Light stone grey',Color=b.fromRGB(229,228,223)},[200]={Name='Lemon metalic',
Color=b.fromRGB(130,138,93)},[199]={Name='Dark stone grey',Color=b.fromRGB(99,95
,98)},[198]={Name='Bright reddish lilac',Color=b.fromRGB(142,66,133)},[196]={
Name='Dark Royal blue',Color=b.fromRGB(35,71,139)},[195]={Name='Royal blue',
Color=b.fromRGB(70,103,164)},[193]={Name='Flame reddish orange',Color=b.fromRGB(
207,96,36)},[192]={Name='Reddish brown',Color=b.fromRGB(105,64,40)},[191]={Name=
'Flame yellowish orange',Color=b.fromRGB(232,171,45)},[190]={Name='Fire Yellow',
Color=b.fromRGB(249,214,46)},[180]={Name='Curry',Color=b.fromRGB(215,169,75)},[
179]={Name='Silver flip/flop',Color=b.fromRGB(137,135,136)},[178]={Name=
'Yellow flip/flop',Color=b.fromRGB(180,132,85)},[176]={Name='Red flip/flop',
Color=b.fromRGB(151,105,91)},[168]={Name='Gun metallic',Color=b.fromRGB(117,108,
98)},[158]={Name='Tr. Flu. Red',Color=b.fromRGB(225,164,194)},[157]={Name=
'Tr. Flu. Yellow',Color=b.fromRGB(255,246,123)},[154]={Name='Dark red',Color=b.
fromRGB(123,46,47)},[153]={Name='Sand red',Color=b.fromRGB(149,121,119)},[151]={
Name='Sand green',Color=b.fromRGB(120,144,130)},[150]={Name=
'Light grey metallic',Color=b.fromRGB(171,173,172)},[149]={Name='Black metallic'
,Color=b.fromRGB(22,29,50)},[148]={Name='Dark grey metallic',Color=b.fromRGB(87,
88,87)},[147]={Name='Sand yellow metallic',Color=b.fromRGB(147,135,103)},[146]={
Name='Sand violet metallic',Color=b.fromRGB(149,142,163)},[145]={Name=
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
if not f[1]or not f[2]or not f[3]then error(`can't initialize BrickColor, invalid Color`
)end local h,i=(math.huge)for j,k in c.Palette do local l=k.Color:distance(f)if
h>l then i=k h=l end end return c.new(i.Name)end return g end function c.random(
)return c.new(e[math.random(1,#e)])end function c.__tostring(f)return f.Name end
c.__index=c end _G.BrickColor=c return b end function a.g()return function(b,c):
any if not b then return c end if not c then return b end for d,e in c do b[d]=e
end return b end end function a.h()local b=a.load'g'local c={}do local d={global
={}}local function constructor(e:any)e='userdata'==type(e)and e or'table'==type(
e)and rawget(e,'Data')assert('userdata'==type(e),`Instance.new: userdata must be a userdata, got {
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
return j end end end return rawget(e,f)or rawget(e,'Data')and constructor(
findfirstchild(e.Data,f))or c[f]end function c.__newindex(e,f:string,g:any)
assert('string'==type(f),`Instance:__newindex: key must be a string, got {type(f
)}`)do local h=e.ClassName local i=d.global[f]or(d[h]and d[h][f])if i and i.
property and i.property.setter then return i.property.setter(e,g)end end return
rawset(e,f,g)end end return c end function a.i()local b=a.load'c'do _G.Vector3=a
.load'd'_G.Vector2=a.load'e'_G.Color3=a.load'f'end local c=a.load'h'do local d=c
.new do c.declare('property','global','Name',{getter=function(e)return getname(e
.Data)end})c.declare('property','global','Parent',{getter=function(e)local f:any
=getparent(e.Data)return f and d(f)end})c.declare('method','global',
'GetChildren',function(e)return b(getchildren(e.Data),d)end)c.declare('method',
'global','GetDescendants',function(e)return b(getdescendants(e.Data),d)end)do
local e=function(e)return function(f,...)local g:any=e(f.Data,...)return g and
d(g)end end c.declare('method','global','FindFirstChild',e(findfirstchild))c.
declare('method','global','FindFirstAncestor',e(findfirstancestor))c.declare(
'method','global','FindFirstChildOfClass',e(findfirstchildofclass))c.declare(
'method','global','FindFirstAncestorOfClass',e(findfirstancestorofclass))c.
declare('method','global','WaitForChild',e(waitforchild))end do local e=function
(e)return function(f,...)return e(f.Data,...)end end c.declare('method','global'
,'SetMemoryValue',e(setmemoryvalue))c.declare('method','global','GetMemoryValue'
,e(getmemoryvalue))c.declare('method','global','Read',e(getmemoryvalue))c.
declare('method','global','Write',e(setmemoryvalue))end c.declare('method',
'global','IsA',function(e,f:string)assert('string'==type(f),`Instance:IsA: class must be a string, got {
type(f)}`)return e.ClassName==f end)c.declare('method','global','IsAncestorOf',
function(e,f)assert('userdata'==type(f)or type(f)=='table'and f.Data,`Instance:IsAncestorOf: other must be a userdata or an Instance, got {
type(f)}`)return isancestorof(e.Data,type(f)=='userdata'and f or f.Data)end)c.
declare('method','global','IsDescendantOf',function(e,f)assert('userdata'==type(
f)or type(f)=='table'and f.Data,`Instance:IsDescendantOf: other must be a userdata or an Instance, got {
type(f)}`)return isdescendantof(e.Data,type(f)=='userdata'and f or f.Data)end)c.
declare('method','global','Destroy',function(e)return destroy(e.Data)end)end do
c.declare('property','DataModel','PlaceId',{getter=function(e)return getplaceid(
)end})c.declare('property','DataModel','GameId',{getter=function(e)return
getgameid()end})c.declare('method','DataModel','GetService',function(e,f:string)
for g,h in getchildren(e.Data)do if getclassname(h)==f then return d(h)end end
return nil end)c.declare('method','DataModel','FindService',function(e,f:string)
local g:any=findservice(e.Data,f)return g and d(g)end)c.declare('method',
'DataModel','HttpGet',function(e,f:string)assert('string'==type(f),`DataModel:HttpGet: url must be a string, got {
type(f)}`)return httpget(f)end)c.declare('method','DataModel','HttpPost',
function(e,f:string,g:string,...)assert('string'==type(f),`DataModel:HttpPost: url must be a string, got {
type(f)}`)assert('string'==type(g),`DataModel:HttpPost: data must be a string, got {
type(g)}`)return httppost(f,g,...)end)end do c.declare('method','HttpService',
'JSONEncode',function(e,f:any)assert('table'==type(f),`HttpService:JSONEncode: value must be a table, got {
type(f)}`)return JSONEncode(f)end)c.declare('method','HttpService','JSONDecode',
function(e,f:string)assert('string'==type(f),`HttpService:JSONDecode: value must be a string, got {
type(f)}`)return JSONDecode(f)end)end do c.declare('property',{'BoolValue',
'IntValue','FloatValue','ObjectValue','StringValue','Vector3Value','ValueBase',
'BrickColorValue','Color3Value','CFrameValue','DoubleConstrainedValue',
'IntConstrainedValue'},'Value',{getter=function(e)return getvalue(e.Data)end,
setter=function(e,f:any)setvalue(e.Data,f)end})end do c.declare('property',{
'UnionOperation','MeshPart','TrussPart','Part'},'Size',{getter=function(e)local
f=getsize(e.Data)return vector.create(f.x,f.y,f.z)end})c.declare('property',{
'UnionOperation','MeshPart','TrussPart','Part','Camera'},'Position',{getter=
function(e)local f=getposition(e.Data)return vector.create(f.x,f.y,f.z)end,
setter=function(e,f:vector|{x:number,y:number,z:number})assert('table'==type(f)
and f.x and f.y and f.z,`Instance:Position: value must be a Vector3, got {type(f
)}`)setposition(e.Data,f)end})c.declare('property',{'UnionOperation','MeshPart',
'TrussPart','Part','Camera'},'CFrame',{getter=function(e)local f=getposition(e.
Data)local g=getupvector(e.Data)local h=getrightvector(e.Data)local i=
getlookvector(e.Data)return{Position=vector.create(f.x,f.y,f.z),UpVector=vector.
create(g.x,g.y,g.z),RightVector=vector.create(h.x,h.y,h.z),LookVector=vector.
create(i.x,i.y,i.z)}end,setter=function(e,f:any)setcframe(e.Data,f)end})c.
declare('property',{'UnionOperation','MeshPart','TrussPart','Part'},
'Transparency',{getter=function(e)return gettransparency(e.Data)end,setter=
function(e,f:number)settransparency(e.Data,f)end})end do c.declare('property',
'Player','Character',{getter=function(e)return d(getcharacter(e.Data))end})c.
declare('property','Player','Team',{getter=function(e)return d(getteam(e.Data))
end})c.declare('property','Player','DisplayName',{getter=function(e)return
getdisplayname(e.Data)end})c.declare('property','Player','UserId',{getter=
function(e)return getuserid(e.Data)end})end do c.declare('property','Workspace',
'CurrentCamera',{getter=function(e)return d(findfirstchildofclass(e.Data,
'Camera'))end})end do c.declare('property','Camera','FieldOfView',{getter=
function(e)return getcamerafov(e.Data)end})c.declare('method','Camera',
'SetCameraSubject',function(e,f)assert(type(f)=='table'and f.Data,`Camera:SetCameraSubject: subject must be an Instance, got {
type(f)}`)return setcamerasubject(f.Data)end)end do c.declare('property',{
'UnionOperation','MeshPart','TrussPart','Part'},'CanCollide',{getter=function(e)
return getcancollide(e.Data)end,setter=function(e,f:boolean)assert(type(f)==
'boolean',`Instance:CanCollide: value must be a boolean, got {type(f)}`)
setcancollide(e.Data,f)end})c.declare('property',{'UnionOperation','MeshPart',
'TrussPart','Part'},'Velocity',{getter=function(e)local f=getvelocity(e.Data)
return vector.create(f.x,f.y,f.z)end,setter=function(e,f:vector|{x:number,y:
number,z:number})assert('table'==type(f)and f.x and f.y and f.z,`Instance:Velocity: value must be a Vector3, got {
type(f)}`)setvelocity(e.Data,f)end})end do c.declare('property','MeshPart',
'TextureID',{getter=function(e)return gettextureid(e.Data)end})c.declare(
'property','MeshPart','MeshID',{getter=function(e)return getmeshid(e.Data)end})
end do c.declare('property','Humanoid','Health',{getter=function(e)return
gethealth(e.Data)end})c.declare('property','Humanoid','MaxHealth',{getter=
function(e)return getmaxhealth(e.Data)end})end do c.declare('property','Model',
'PrimaryPart',{getter=function(e)return d(getprimarypart(e.Data))end})end do c.
declare('property','BillboardGui','Adornee',{getter=function(e)return d(
getadornee(e.Data))end})end do c.declare('property','Players','LocalPlayer',{
getter=function(e)return d(getlocalplayer())end})end do c.declare('method',
'MouseService','GetMousePosition',function(e)local f=getmouseposition()return
vector.create(f.x,f.y)end)c.declare('method','MouseService','GetMouseLocation',
function(e)local f=getmouselocation(e.Data)return vector.create(f.x,f.y)end)c.
declare('method','MouseService','GetMouseBehavior',function(e)return
getmousebehavior(e.Data)end)c.declare('method','MouseService',
'GetMouseDeltaSensitivity',function(e)return getmousedeltasensitivity(e.Data)end
)c.declare('method','MouseService','IsMouseIconEnabled',function(e)return
ismouseiconenabled(e.Data)end)c.declare('method','MouseService',
'SetMouseLocation',function(e,f,g)assert('number'==type(f),`MouseService:SetMouseLocation: x must be a number, got {
type(f)}`)assert('number'==type(g),`MouseService:SetMouseLocation: y must be a number, got {
type(g)}`)setmouselocation(e.Data,f,g)end)c.declare('method','MouseService',
'SetMouseIconEnabled',function(e,f)assert('boolean'==type(f),`MouseService:SetMouseIconEnabled: enabled must be a boolean, got {
type(f)}`)setmouseiconenabled(e.Data,f)end)c.declare('method','MouseService',
'SetMouseBehavior',function(e,f)assert('number'==type(f),`MouseService:SetMouseBehavior: behavior must be a number, got {
type(f)}`)setmousebehaviour(e.Data,f)end)c.declare('method','MouseService',
'SetMouseDeltaSensitivity',function(e,f)assert('number'==type(f),`MouseService:SetMouseDeltaSensitivity: sensitivity must be a number, got {
type(f)}`)setmousedeltasensitivity(e.Data,f)end)c.declare('method',
'MouseService','SmoothMouseExponential',function(e,f,g,h)assert('table'==type(f)
and#f>=2,`MouseService:SmoothMouseExponential: origin must be a table with at least 2 numbers, got {
type(f)}`)assert('table'==type(g)and#g>=2,`MouseService:SmoothMouseExponential: point must be a table with at least 2 numbers, got {
type(g)}`)assert('number'==type(h),`MouseService:SmoothMouseExponential: speed must be a number, got {
type(h)}`)local i=smoothmouse_exponential(f,g,h)return vector.create(i.x,i.y)end
)c.declare('method','MouseService','SmoothMouseLinear',function(e,f,g,h,i)
assert('table'==type(f)and#f>=2,`MouseService:SmoothMouseLinear: origin must be a table with at least 2 numbers, got {
type(f)}`)assert('table'==type(g)and#g>=2,`MouseService:SmoothMouseLinear: point must be a table with at least 2 numbers, got {
type(g)}`)assert('number'==type(h),`MouseService:SmoothMouseLinear: sensitivity must be a number, got {
type(h)}`)assert('number'==type(i),`MouseService:SmoothMouseLinear: smoothness must be a number, got {
type(i)}`)local j=smoothmouse_linear(f,g,h,i)return vector.create(j.x,j.y)end)
end end _G.Instance=c _G.workspace=c.new(Workspace)_G.game=c.new(Game)return{
Instance=c,workspace=_G.workspace,game=_G.game}end end _G.websocket=a.load'a'_G.
signal=a.load'b'a.load'i'